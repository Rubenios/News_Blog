<?php

class User
{
    public static function register($login, $password, $email)
    {
        $db = Db::getConnection();
        $query = "INSERT INTO users(Login,Password,Email) VALUES ('$login','$password','$email')";
        $result = $db->query($query);
        return $result;
    }


    public static function login($login)
    {
        $db = Db::getConnection();
        $query = "SELECT u.id_user, u.id_privilege, u.Login, u.Password, u.Email FROM users u 
                  INNER JOIN privilege ON u.id_privilege = privilege.id_privilege WHERE u.Login = ?";
        $result = $db->prepare($query);
        $result->execute(["$login"]);
        $dataUser = $result->fetch(PDO::FETCH_ASSOC);
        $_SESSION['logged_user'] = $dataUser;
    }


    public static function checkUserData($login,$password)
    {
        $errors = false;
        $db = Db::getConnection();
        $query = "SELECT COUNT(Login) FROM users WHERE Login=?;";
        $result = $db->prepare($query);
        $result->execute(["$login"]);
        $checkLogin = $result->fetch(PDO::FETCH_NUM);
        if ($checkLogin[0] == 1){
            $query = "SELECT Login, Password FROM users WHERE Login=?";
            $result = $db->prepare($query);
            $result->execute(["$login"]);
            $userData = $result->fetch(PDO::FETCH_ASSOC);
            if (password_verify($password,$userData['Password'])){
                return false;
            }else{
                $errors[]="The password is incorrect";
            }
        }else{
            $errors[]="This username does not exist";
        }
        return $errors;
    }

    public static function checkAllData($login,$password,$passwordagain,$email){
        $errors = false;

        if (!self::checkLogin($login)){
            $errors[] = "Login must consist from 3 to 15 Latin alphabet characters!";
        }

        if (!self::checkLoginExist($login)){
            $errors[] = "Username with this login already exist!";
        }

        if (!self::checkPassword($password)){
            $errors[] = "Password must consist from 5 to 15 Latin alphabet characters!";
        }

        if (!self::checkPasswordAgain($password, $passwordagain)){
            $errors[] = "Passwords don't match!";
        }
		
		if (!self::checkEmail($email)){
            $errors[] = "This email is not valid!";
        }

        if (!self::checkEmailExist($email)){
            $errors[] = "Username with this email already exist!";
        }

        return $errors;
    }

    private static function checkLogin($login){
        $pattern = '~[a-zA-Z0-9]{3,15}~';
        if (preg_match($pattern, $login) != false){
            return true;
        }else{
            return false;
        }
    }

    private static function checkEmail($email){
        $pattern = '~(\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,6})~';
        if (preg_match($pattern, $email) != false){
            return true;
        }else{
            return false;
        }
    }

    private static function checkPassword($password){
        $pattern = '~[a-zA-Z0-9]{5,15}~';
        if (preg_match($pattern, $password)){
            return true;
        }else{
            return false;
        }
    }

    private static function checkPasswordAgain($password, $passwordagain){
        if ($password === $passwordagain){
            return true;
        }else{
            return false;
        }
    }

    private static function checkEmailExist($email){
        $db = Db::getConnection();
        $query = "SELECT COUNT(u.email_user) FROM users u WHERE u.email_user=?;";
        $result = $db->prepare($query);
        $result->execute(["$email"]);
        $checkEmailExist = $result->fetch(PDO::FETCH_NUM);
        if ($checkEmailExist[0] == 0){
            return true;
        }else{
            return false;
        }
    }

    private static function checkLoginExist($login){
        $db = Db::getConnection();
        $query = "SELECT COUNT(u.login) FROM users u WHERE u.login=?;";
        $result = $db->prepare($query);
        $result->execute(["$login"]);
        $checkLoginExist = $result->fetch(PDO::FETCH_NUM);
        if ($checkLoginExist[0] == 0){
            return true;
        }else{
            return false;
        }
    }
}
