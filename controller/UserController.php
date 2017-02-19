<?php

include_once ROOT."/model/user.php";
include_once ROOT."/components/db.php";

class UserController{
    public function actionRegister(){
        $login = '';
        $password = '';
        $passwordagain = '';
		$email = '';

        if (isset($_POST['submit'])){
            $login = htmlspecialchars($_POST['Login']);
            $password = htmlspecialchars($_POST['Password']);
            $passwordagain = htmlspecialchars($_POST['Passwordagain']);
			$email = htmlspecialchars($_POST['Email']);
        }

        $errors = User::checkAllData($login,$password,$passwordagain,$email);

        if ($errors == false){
            $password = password_hash($password, PASSWORD_DEFAULT);
            User::register($login, $password, $email);
            header ("Location: /user/login");
        }

        require_once ROOT."/view/user/register.php";
        return true;
    }

    public function actionLogin(){

        if (isset($_POST['submit'])){
            $login = htmlspecialchars($_POST['Login']);
            $password = htmlspecialchars($_POST['Password']);
            $errors = User::checkUserData($login,$password);
            if ($errors == false){
                User::login($login);
                header ("Location: /");
            }
        }
        require_once ROOT."/view/user/login.php";
        return true;
    }

    public function actionLogout(){
        unset($_SESSION['logged_user']);
        header ("Location: /");
        return true;
    }
}