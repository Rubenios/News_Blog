--
-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 7.2.53.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 20.01.2017 22:43:32
-- Версия сервера: 5.7.16-log
-- Версия клиента: 4.1
--


--
-- Описание для базы данных projecthtp
--
DROP DATABASE IF EXISTS projecthtp;
CREATE DATABASE IF NOT EXISTS projecthtp
	CHARACTER SET utf8
	COLLATE utf8_general_ci;

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

-- 
-- Установка базы данных по умолчанию
--
USE projecthtp;

--
-- Описание для таблицы category
--
CREATE TABLE IF NOT EXISTS category (
  id_category INT(11) NOT NULL AUTO_INCREMENT,
  id_parent INT(11) NOT NULL,
  category VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_category)
)
ENGINE = INNODB
AUTO_INCREMENT = 7
AVG_ROW_LENGTH = 528
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы newstype
--
CREATE TABLE IF NOT EXISTS newstype (
  id_newstype INT(11) NOT NULL AUTO_INCREMENT,
  news_type VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (id_newstype)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы privilege
--
CREATE TABLE IF NOT EXISTS privilege (
  id_privilege INT(11) NOT NULL AUTO_INCREMENT,
  type_privilege CHAR(5) DEFAULT NULL,
  PRIMARY KEY (id_privilege)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы manufacturers
--
CREATE TABLE IF NOT EXISTS manufacturers (
  id_manufacturer INT(11) NOT NULL AUTO_INCREMENT,
  id_category INT(11) NOT NULL,
  id_man_info INT(11) NOT NULL,
  Name_manuf VARCHAR(100) NOT NULL,
  Man_city VARCHAR(20) NOT NULL,
  Man_street VARCHAR(45) NOT NULL,
  Man_telephone VARCHAR(45) NOT NULL,
  Man_telephone1 VARCHAR(45) DEFAULT NULL,
  Man_telephone2 VARCHAR(45) DEFAULT NULL,
  Man_fax VARCHAR(45) NOT NULL,
  Man_url VARCHAR(45) NOT NULL,
  Man_email VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_manufacturer),
  INDEX FK_manufacturers_man_info_id_man_info (id_man_info),
  INDEX id_category (id_category),
  CONSTRAINT manufacturers_ibfk_1 FOREIGN KEY (id_category)
    REFERENCES category(id_category) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы users
--
CREATE TABLE IF NOT EXISTS users (
  id_user INT(11) NOT NULL AUTO_INCREMENT,
  id_privilege INT(11) NOT NULL DEFAULT 2,
  Login VARCHAR(50) DEFAULT NULL,
  Password VARCHAR(255) NOT NULL,
  Email VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_user),
  INDEX id_privilege (id_privilege),
  CONSTRAINT users_ibfk_1 FOREIGN KEY (id_privilege)
    REFERENCES privilege(id_privilege) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 9
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы man_info
--
CREATE TABLE IF NOT EXISTS man_info (
  id_man_info INT(11) NOT NULL AUTO_INCREMENT,
  Description TEXT NOT NULL,
  PRIMARY KEY (id_man_info),
  CONSTRAINT FK_man_info_manufacturers_id_man_info FOREIGN KEY (id_man_info)
    REFERENCES manufacturers(id_man_info) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы news
--
CREATE TABLE IF NOT EXISTS news (
  id_news INT(11) NOT NULL AUTO_INCREMENT,
  id_manufacturer INT(11) NOT NULL,
  id_category INT(11) NOT NULL,
  id_user INT(11) NOT NULL,
  id_newstype INT(11) NOT NULL,
  Title VARCHAR(200) NOT NULL,
  News TEXT NOT NULL,
  Newsdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_news),
  INDEX id_category (id_category),
  INDEX id_manufacturer (id_manufacturer),
  INDEX id_user (id_user),
  CONSTRAINT news_ibfk_1 FOREIGN KEY (id_manufacturer)
    REFERENCES manufacturers(id_manufacturer) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT news_ibfk_2 FOREIGN KEY (id_category)
    REFERENCES category(id_category) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT news_ibfk_3 FOREIGN KEY (id_user)
    REFERENCES users(id_user) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT news_ibfk_4 FOREIGN KEY (id_newstype)
    REFERENCES newstype(id_newstype) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 12
AVG_ROW_LENGTH = 40960
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы media
--
CREATE TABLE IF NOT EXISTS media (
  id_media INT(11) NOT NULL AUTO_INCREMENT,
  image_path VARCHAR(255) NOT NULL,
  video_path VARCHAR(255) DEFAULT NULL,
  id_news INT(11) NOT NULL,
  PRIMARY KEY (id_media),
  INDEX id_news (id_news),
  CONSTRAINT media_ibfk_1 FOREIGN KEY (id_news)
    REFERENCES news(id_news) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 12
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

--
-- Описание для таблицы posts
--
CREATE TABLE IF NOT EXISTS posts (
  id_posts INT(11) NOT NULL AUTO_INCREMENT,
  id_user INT(11) NOT NULL,
  id_news INT(11) NOT NULL,
  Post TEXT NOT NULL,
  Date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id_posts),
  INDEX id_user (id_user),
  CONSTRAINT posts_ibfk_1 FOREIGN KEY (id_user)
    REFERENCES users(id_user) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT posts_ibfk_2 FOREIGN KEY (id_news)
    REFERENCES news(id_news) ON DELETE RESTRICT ON UPDATE RESTRICT
)
ENGINE = INNODB
AUTO_INCREMENT = 17
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci
ROW_FORMAT = DYNAMIC;

-- 
-- Вывод данных для таблицы category
--
INSERT INTO category VALUES
(1, 0, 'Electronics'),
(2, 0, 'Beauty and Sport'),
(3, 0, 'For Home'),
(4, 0, 'Food'),
(5, 0, 'Clothes'),
(6, 0, 'Others');

-- 
-- Вывод данных для таблицы newstype
--
INSERT INTO newstype VALUES
(1, 'News'),
(2, 'Reviews'),
(3, 'Manufacturers');

-- 
-- Вывод данных для таблицы privilege
--
INSERT INTO privilege VALUES
(1, 'admin'),
(2, 'user');

-- 
-- Вывод данных для таблицы manufacturers
--
INSERT INTO manufacturers VALUES
(1, 1, 1, 'ЗАТ Мiнскi завод халадзiльнiкаў "Атлант"', 'Мiнск', 'вул. Пераможцаў, 61', '+375(17)218-62-22', NULL, NULL, '+375(17)203-96-97', 'www.atlant.by', 'info@atlant.by'),
(2, 1, 2, 'Унiтарнае прадпрыемства "ЗЭБТ Гарызонт"', 'Мiнск', 'зав. С.Кавалеўскай, 62, к.16', '+375(17)226-36-01', NULL, NULL, '+375(17)226-36-07', 'www.horizont.by', 'zebt@horizont.by'),
(3, 1, 3, 'ААТ "Вiцязь"', 'Вiцебск', 'вул. Петруся Броўкi, 13А', '+375(212)57-92-13', NULL, NULL, '+375(212)57-52-26', 'www.vityas.com', 'tv@vityas.com');

-- 
-- Вывод данных для таблицы users
--
INSERT INTO users VALUES
(1, 1, 'Rubenio', '$2y$10$i8nvTQvOMc5f6eOBbyMOlOi61M11S3eqCEwHDdo5E/X6Y71t/NVMa', 'mightyphp@gmail.com'),
(2, 2, 'Gronn', '$2y$10$1o7NIsdplI52gi5P.em.pOHeRc7NQ0fa3ev/oPFAzY7mfRbR1Quf.', 'gronn@tut.by'),
(8, 2, 'IggyPop', '$2y$10$JFo2JwlFIpQGCt5q97XGQuvx499jFnQ1HvBJdo7rfLfw4rVqI/eG.', 'iggy@tut.by');

-- 
-- Вывод данных для таблицы man_info
--
INSERT INTO man_info VALUES
(1, 'Зачыненае акцыянернае таварыства «Атлант» — беларуская кампанія, у структуру якой уваходзяць тры прадпрыемствы: Мінскі завод халадзільнікаў, Завод побытавай тэхнікі і Баранавіцкі станкабудаўнічы завод, якiя выпускаюць халадзільнікі, пральныя машыны, чайнікі электрычныя, газавыя і электрычныя пліты. У 2010 годзе прадпрыемства ўваходзіла ў Топ-10 валаўтваральных прадпрыемстваў Беларусі.'),
(2, 'Холдынг «Гарызонт», галаўное прадпрыемства ААТ «Кіроўная кампанія холдынга „Гарызонт“» (Адкрытае акцыянернае таварыства «Кіроўная кампанія холдынга „Гарызонт“», — мінскае прадпрыемства, найбуйны ў Беларусі і адзін з найбуйных у краінах СНД вытворца спажывецкай электронікі і побытавай тэхнікі.'),
(3, 'ААТ «Віцязь» (лат. «Vityas») — прамысловае прадпрыемства Віцебска, буйны вытворца тэлевізійнай тэхнікі і побытавай электронікі, адно з буйных прадпрыемстваў у Рэспубліцы Беларусь. З 16 сакавіка 2010 года форма ўласнасці змянілася на ААТ.');

-- 
-- Вывод данных для таблицы news
--
INSERT INTO news VALUES
(1, 1, 1, 1, 2, 'Тест стиральной машины Atlant СМА 70С1010: стирает все', '<p>Знакомство со стиральной машиной — это знакомство с ее интерфейсом. В модели применена современная электронная система. Ее особенность, \r\n\t\tпрежде всего, в логичном размещении и устройстве элементов. Логика связана с тем, как мы воспринимаем информацию. Мы привыкли, что это \r\n\t\tпроисходит слева направо. Вот и при настройках работы взгляд пользователя двигается слева (где мы насыпаем порошок и все остальное в лоток), \r\n\t\tпостепенно перемещаясь направо.</p>\r\n\t\t<p>Первое, что нужно выбрать пользователю, — программу стирки. Это делается большим селектором (вращать его можно как по часовой стрелке, \r\n\t\tтак и против, кстати, ход легкий, отзывчивый). При этом сразу включается индикация — все видно и понятно. Теперь уточним программу. \r\n\t\tДля чего на поле дисплея размещены кнопки с индикаторами. Настроек температуры на нем пять (20, 30, 40, 60 и 90°С). Четыре варианта \r\n\t\tскорости вращения барабана при отжиме (1200/1000/800/400), либо отжим можно отключить. Кнопки опций и таймера. А также цифровой дисплей \r\n\t\tдля отражения настроек таймера и отображения времени до завершения стирки. Таймер позволяет отложить начало стирки на время от часа до суток.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../style/images/Atlant_СМА_70С1010/zony_upravlenija_70S101_opt.jpg" alt="" width="689" height="212" /></p>\r\n\t\t<p> </p>\r\n\t\t<p>После введения всех необходимых параметров остается нажать кнопку старта. Как и все индикаторы, она имеет красивую синюю подсветку и \r\n\t\tувеличенный размер. Эта подсветка и само очертание кнопки помогают сообразить, как включить машину, даже тем, кто пока не прочел инструкцию.</p>\r\n\t\t<p>Надо отметить, что кнопка имеет еще одно назначение: с ее помощью можно включать паузу и ненадолго останавливать программу. При включении \r\n\t\tпаузы дверцу люка можно открывать, чтобы добавить забытую вещицу или вынуть что-то из кармана.</p>\r\n\t\t<p>Кроме световой используется еще и звуковая индикация. Она имеет несколько мелодий, звучит негромко и помогает быстрее ориентироваться в \r\n\t\tпроисходящем.</p>\r\n\t\t<p> </p>\r\n\t\t<p><strong>Конструктивный подход</strong></p>\r\n\t\t<p><strong>Атлант СМА 70С1010</strong> имеет высокие показатели экономичности. Она на 20% экономнее, чем машина класса А. То есть в обозначении \r\n\t\tна энергетической наклейке указано А++. Это значит, что система оптимизации, которая оценивает каждую порцию белья, не допускает перерасхода \r\n\t\tводы и электроэнергии. Система гибко подходит к каждой стирке, вне зависимости от того, что стирается: пара носков или 7 кг постельного белья.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/baraban_optx78.gif" alt="" width="600" height="469" /></p>\r\n\t\t<p> </p>\r\n\t\t<p>Бак машины изготавливается из высокопрочного композитного материала — полипропилена, который не только прекрасно выдерживает механические \r\n\t\tнагрузки, но и снижает шум. Материал бака помогает дольше поддерживать температуру воды, что немаловажно для качества стирки. Барабан выполнен \r\n\t\tиз нержавеющей стали.</p>\r\n\t\t<p>Стенка барана перфорирована. Благодаря специальной форме гребня белье при стирке и отжиме деликатно захватывается и перемещается. Большое \r\n\t\tчисло отверстий позволяет лучше и быстрее белью пропитываться моющим раствором.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/IMG_2473_optx78.gif" alt="" width="600" height="426" /></p>\r\n\t\t<p><strong> </strong></p>\r\n\t\t<p><strong>Увеличенная в диаметре дверца</strong></p>\r\n\t\t<p>Уровень шума — вопрос тоже очень актуальный. Тихая работа данной стиральной машины обеспечена за счет современного решения узлов. Но важнее \r\n\t\tвсего двигатели. Их производят по лицензии фирмы «BOSCH-SIEMENS». Они обладают наилучшими характеристиками.</p>\r\n\t\t<p>Среди очевидных достоинств стиральных машин СМА 70C1010 — низкий уровень вибрации. В чем мы также убедились в ходе теста. Система \r\n\t\tбалансировки колебательного узла проработана четко. В ходе отжима машина стоит неподвижно, малозаметные колебательные движения затрагивают \r\n\t\tтолько верхнюю часть корпуса.</p>\r\n\t\t<p>Прибор защищен от перепадов напряжения в электросети. Машина стабильно работает при скачках от 170 до 255 В.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/atlant_sma_70s1010_12.jpg" alt="" width="528" height="500" /></p>\r\n\t\t<p> </p>\r\n\t\t<p><strong>Технические характеристики <strong>Атлант СМА 70С1010</strong></p>\r\n\t\t<p><strong>Загрузка:</strong> 7 кг.</p>\r\n\t\t<p><strong>Стирка:</strong> класс А.</p>\r\n\t\t<p><strong>Программы:</strong> Хлопок, Синтетика, Смешанные, Шерсть, Шелк, Ручная, Супербыстро 15 мин, Детская одежда, Рубашки, Джинсы, \r\n\t\tСпортивная обувь, Темные вещи, Верхняя одежда.</p>\r\n\t\t<p><strong>Дополнительные возможности:</strong> замачивание, предварительная, интенсивная, ночная, эко, легкое глажение, дополнительное \r\n\t\tполоскание, остановка с водой в баке, таймер 24 ч.</p>\r\n\t\t<p><strong>Отжим:</strong> С, 1000 об/мин.</p>\r\n\t\t<p><strong>Экономичность:</strong> класс А++ (А-20%), расход электроэнергии 1,33 кВт?ч, воды 55 л (хлопок 60°С); в расчете на кг белья: 0,19 кВт?ч и 7,86 л.</p>\r\n\t\t<p><strong>Управление:</strong> селектор программ, LED-дисплей, кнопки выбора температуры, скорости отжима, включения опций, таймера; \r\n\t\tиндикация этапа программы, настроек таймера, времени до завершения стирки, включения опций.</p>\r\n\t\t<p><strong>Автоматика:</strong> оптимизация загрузки, контроль уровня пены, дисбаланса.</p>\r\n\t\t<p><strong>Безопасность:</strong> защита от протечек Аqua-Protect на шланги, защита от перепадов напряжения, защита от детей.</p>\r\n\t\t<p><strong>Конструкция:</strong> бак полипропилен, барабан 52,5 л, уровень шума стирка/отжим 59/73 дБ, открывание люка 150°, наклонная \r\n\t\tпанель управления.</p>\r\n\t\t<p><strong>Габариты:</strong> 596х482х846 мм. МАССА: 63 кг.</p>\r\n\t\t<p><strong>Гарантия:</strong> 3 года.</p>\r\n\t\t<p> <img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/IMG_2471_optx78.gif" alt="" width="600" height="424" /></p>\r\n\t\t<p><strong> </strong></p>\r\n\t\t<p><strong>Постирал и надел</strong></p>\r\n\t\t<p><strong>Тест № 1</strong></p>\r\n\t\t<p><strong>Задача:</strong> оценка возможностей программы «Супербыстро 15 мин».</p>\r\n\t\t<p>Короткие программы становятся все более популярны. В данном случае имеется не просто короткая, а суперкороткая программа. Она, включая \r\n\t\tэтапы стирки, полоскания и отжима. Длится она всего 15 минут. Чтобы посмотреть, как работает столь быстрая стирка, мы взяли классическую \r\n\t\tрубашку из хлопка. Ее немного поносили, она помялась, воротничок потерял свежесть. И хотя заметных загрязнений на ней не видно, но надевать \r\n\t\tвторой раз уже не хотелось.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/IMG_2484_opt79.gif" alt="" width="460" height="600" /></p>\r\n\t\t<p> </p>\r\n\t\t<p>Программа на самом деле продолжалась только 15 минут. Причем непосредственно стирка по продолжительности занимает примерно половину \r\n\t\tвсей программы. Температуру воды оставили по умолчанию — 30°С, можно было понизить до 20°С. Не стали менять и скорость отжима. Начало \r\n\t\tстирки можно перенести при помощи таймера, но мы этого не делали. Другая опция — «Легкое глажение» слегка изменит программу, ее тоже не \r\n\t\tстали включать. Хотя в ходе испытаний выяснилось, что без нее вполне можно обойтись. Благодаря не самому низкому уровню воды рубашка не \r\n\t\tсильно помялась при стирке, и после высушивания ее можно было вообще не гладить.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/IMG_2464_optx78.gif" alt="" width="455" height="650" /></p>\r\n\t\t<p>Результат: белоснежная свежая рубашка, чистый воротничок. Программа действительно эффективна и может использоваться для малоношенных \r\n\t\tблузок, футболок, сорочек из хлопка. Пока шел тест, наша рубашка успела высохнуть, и ее действительно можно было спокойно надеть.</p>\r\n\t\t<p> </p>\r\n\t\t<p><strong>Победа над пятнами</strong></p>\r\n\t\t<p><strong>Тест № 2</strong></p>\r\n\t\t<p><strong>Задача:</strong> отстирывание сложных пятен, стирка хлопка, 60°С.</p>\r\n\t\t<p>Теперь машине предстоит более сложная работа. На образце (это тоже рубашка, но другая, лен) нанесены четыре вида пятен — маркеры. Это:</p>\r\n\t\t<p>Майонез — оставляет жирные, немного пигментированные пятна.</p>\r\n\t\t<p>Кетчуп — из-за наличия в томатах каротина и ликопина оставляет красно-коричневые пятна, отстирывается плохо.</p>\r\n\t\t<p>Кофе — коричневые, слегка маслянистые пятна.</p>\r\n\t\t<p>Трава — стойкий пигмент зеленого цвета.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/IMG_2474_optx78.gif" alt="" width="650" height="450" /></p>\r\n\t\t<p> </p>\r\n\t\t<p> </p>\r\n\t\t<p>Программу выбрали основную — хлопок. Температуру установили 60°С. Ни замачивания, ни интенсивной стирки не применяли. Хотели оценить \r\n\t\tпрограмму как она есть.</p>\r\n\t\t<p>Первое, на что обратили внимание, — высокий уровень воды и ее нагрев. Вода оставалась нестерпимо горячей (мы специально делали паузу, \r\n\t\tчтобы открыть люк и проверить) до самого этапа полоскания. Это значит, что с загрязнениями программа борется одинаково эффективно и в \r\n\t\tначале процесса, и к его завершению. Стирка была интенсивной и продлилась около двух часов.</p>\r\n\t\t<p>Затем опять же интенсивное полоскание и отжим.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/IMG_2490_optx78.gif" alt="" width="600" height="429" /></p>\r\n\t\t<p> </p>\r\n\t\t<p> </p>\r\n\t\t<p>Результат: все маркеры без исключения отстирались полностью, без ореолов и малозаметных следов. Идеально чисто. Особенно интересно \r\n\t\tбыло увидеть, что произойдет с пятном от кетчупа. Его специально нанесли  густым слоем. Причем сделано это было накануне вечером, пятна \r\n\t\tуспели въесться, хорошенько засохнуть, схватиться с волокнами. Но, несмотря на сложность задачи, машинка справилась.</p>\r\n\t\t<p> </p>\r\n\t\t<p><strong>Как новые</strong></p>\r\n\t\t<p><strong>Тест № 3</strong></p>\r\n\t\t<p><strong>Задача:</strong> стирка обуви, нужно проверить, что это эффективно и безопасно для нее.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/IMG_2487_optx78.gif" alt="" width="600" height="412" /></p>\r\n\t\t<p> </p>\r\n\t\t<p>Программа стирки обуви в машинках встречается довольно редко. Однако мы уже привыкли стирать кроссовки и кеды в обычных программах, \r\n\t\tрискуя каждый раз нечаянно испортить любимую пару. Специальная программа обязана обеспечить сохранность изделий и привести их в полный \r\n\t\tпорядок. В тесте принимали участие белые хорошо поношенные кроссовки, с грязными шнурками и подошвой. Для чистоты эксперимента мы их \r\n\t\tпросто опустили в барабан, в обычной ситуации лучше стирать обувь в мешке для стирки (из сетчатого материала или хлопка).</p>\r\n\t\t<p>За один раз машина способна постирать две пары. Вода слегка подогревается до 20 или 30°С.</p>\r\n\t\t<p>Стирка идет достаточно интенсивно, барабан все время вращается, воды много, и, что особенно заметно, она очень грязная. \r\n\t\tОтжим достаточно деликатный.</p>\r\n\t\t<p>Результат: первое, на что мы сразу посмотрели, были шнурки. Мы были уверены, что они останутся в своем прежнем состоянии. \r\n\t\tОднако они стали белыми, причем простирались и сверху и внутри шнуровки. Кожа тоже стала белой, загрязнения с нее смылись. \r\n\t\tПорадовало идеальное состояние подошвы.</p>\r\n\t\t<p> </p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="../images/Atlant_СМА_70С1010/IMG_2508_optx78.gif" alt="" width="600" height="400" /></p>\r\n\t\t<p> </p>\r\n\t\t<p><strong>Впечатление</strong></p>\r\n\t\t<p>Отличные результаты стирки и приятное знакомство. <strong>Атлант СМА 70С1010</strong> предлагает хозяйке современный подход к стирке. \r\n\t\tЭто полный набор программ, включая специальные режимы по уходу за одеждой малыша, темными вещами, джинсами, верхней одеждой (куртки, \r\n\t\tплащи, пуховики), рубашками, изделиями из шерсти и шелка и др.</p>\r\n\t\t<p>Обилие программ всегда упрощает работу — не нужно вникать в настройки, прикидывать оптимальную температуру и скорость отжима. \r\n\t\tНе менее значимо наличие опций, которые дают возможность усилить эффект стирки в зависимости от состояния вещей, упростить \r\n\t\tпоследующий уход за ними.</p>\r\n\t\t<p>А еще радует продуманный, привлекательный дизайн машины. Это тоже важно, ведь это и повседневное удобство, и приятное глазу \r\n\t\tзрелище, которое поднимает настроение и помогает превратить рутинную работу в удовольствие.</p>', '2017-01-15 18:58:10'),
(2, 2, 1, 2, 1, 'Android по-белорусски. Тестируем умный телевизор «Витязь»', '<p>Сколько копий переломано в сражениях тех, кто за белорусскую технику и кто против нее. Оба «фронта» неплохо вооружены фактами и предрассудками, которые, как правило, основаны на \r\n\t\tустоявшемся в обществе отношении. Наш тест показал, что найти отличия отечественной техники от импортной сложно: компоненты решают все и потому взгляд неопытного потребителя вряд \r\n\t\tли определит производителя, основываясь на дизайне или базовых характеристиках.</p>\r\n\t\t<p>В мае 2016 года на белорусском рынке появился телевизор «Витязь» под управлением операционной системы Android, и мы решили выяснить, что это за зверь. \r\n\t\tЧестно говоря, определенная предвзятость была с самого начала. Представители рода «Покупатель обыкновенный» всегда ищут максимум выгоды для себя. Что \r\n\t\tэто значит? Если речь о телевизоре, то он должен отвечать набору требований к дизайну, возможностям, качеству изображения и ряду других параметров. \r\n\t\tКонечно, не последнюю, но и не решающую роль играет цена.</p>\r\n\t\t<p>Приоритеты несколько смещаются, когда речь идет о белорусском товаре. Здесь практически каждый во главу угла ставит именно цену: принято считать, \r\n\t\tчто белорусское должно быть сперва дешевым, а потом — все остальное. Почему? Это скорее риторический вопрос.</p>\r\n\t\t<p>Итак, в редакцию Onliner.by прибыл тот самый телевизор «Витязь», который оценивался с точки зрения того самого рядового покупателя, а не технического \r\n\t\tспециалиста: мало кто берет в магазин колориметр и другие приборы.</p>\r\n\r\n\t\t<h3>Дизайн</h3>\r\n\r\n\t\t<p>Встречают по одежке, и от этого никуда не денешься. Первые впечатления: телевизор «Витязь» ничем не отличается от импортных аналогов. Черный \r\n\t\tпрямоугольник на изогнутых и в какой-то мере даже изящных матовых ножках. Очень легкий (в сравнении с нашим офисным LG с такой же диагональю — 42 дюйма). \r\n\t\tСтандартной толщины глянцевая рамка вокруг экрана, логотип внизу.</p>\r\n\t\t<p>Теперь о мелочах. Индикатор включения телевизора находится сбоку справа и размещен в выступающем элементе. Светодиод виден в окошко полностью — \r\n\t\tс «патроном». То есть это не миниатюрное отверстие, испускающее свет, а прозрачный пластик, прикрывающий нишу с миниатюрной лампочкой. В этой же \r\n\t\tконструкции разместился ИК-сенсор. Очевидно, что, интегрировав оба элемента в рамку, можно было улучшить дизайн и убрать лишний «прыщ». Правда, \r\n\t\tэто усложнило бы работу проектировщиков.</p>\r\n\r\n\t\t<p>На заднюю панель мало кто смотрит, но мы все же обратили на нее внимание. Крышка выполнена из черного пластика с элементами, которые можно \r\n\t\tназвать ребрами жесткости. Может быть, они как-то влияют на циркуляцию воздуха внутри корпуса, но наверняка утверждать не будем.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/005.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p>Громкоговорители не прячутся в корпусе, а размещены в двух выступающих модулях сзади — справа и слева. Решетки направлены вниз.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/006.jpg" alt="" width="690" height="459" /></p>\r\n\r\n\t\t<p>Все доступные разъемы расположены на возвышении (в пьедестале, судя по всему, прячется «мозг»). Сбоку — оптический вход, два USB 2.0, \r\n\t\tслот для CI-модуля, один HDMI, один USB 3.0 и антенный вход. Внизу — неотсоединяющийся кабель питания, разъем для наушников, разъем для \r\n\t\tEthernet, еще один HDMI, SCART, разъем для приема аудиосигнала от компьютера и VGA-интерфейс. Модуль Wi-Fi не виден, но мы все равно \r\n\t\tне смогли им воспользоваться из-за протокола WPA2 Enterprise.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/007.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/008.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p>Набор физических элементов управления — громкость, включение, переключение каналов — находится сбоку справа в еще одном выглядящем \r\n\t\tчужеродно модуле. При близком рассмотрении он напоминает о кинескопных телевизорах «Витязь» и, честно говоря, отправляет в прошлое \r\n\t\t(а может, это придирки?).</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/009.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/010.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p>Таким образом, о внешнем виде телеприемника можно сказать следующее: спереди это вполне современное устройство (за исключением \r\n\t\tбугорка с индикатором включения и ИК-сенсором). Сзади конструкция походит на какой-то научный прибор с лишними глазу элементами, \r\n\t\tсоздающими впечатление перегруженности.</p>\r\n\r\n\t\t<p>В пользу «Витязя» говорит то, что увидевшие его впервые не замечали подмены, считая, что на столе стоит наш офисный \r\n\t\tимпортный телевизор. Лишь заметив логотип, удивлялись и начинали рассматривать новинку пристальнее.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/011.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<h3>Экран</h3>\r\n\r\n\t\t<p>Экран телевизора имеет разрешение формата Full HD, а вот эмулятор Android-устройства — нет. Внешний источник может передавать \r\n\t\tконтент в формате 1080p, и он будет прекрасно воспроизводиться (например, с флешки или ноутбука). Если же вы решите посерфить \r\n\t\tпо интернету, то картинка на 42-дюймовом экране окажется в разрешении HD. По этой причине, как утверждают наши эксперты, \r\n\t\tинтерфейс выглядит «мыльным», качество видеороликов на YouTube страдает, изображения пикселизируются.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/012.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p>При заливке белым искушенный зритель заметит неравномерность подсветки — видны несколько желтоватых областей и в углах \r\n\t\tпоявляется тень. В подвижных сценах артефакты незаметны. Также есть возможность придраться к черному и серому цветам: \r\n\t\tчерный при ярком внешнем освещении кажется чуть ли не идеальным, но сбоку видны засветы в углах. Серый цвет тоже неравномерный.</p>\r\n\r\n\t\t<p>Цвета яркие, поэтому, настроив систему, можно добиться «вырвиглазных» сочных оттенков. То есть запаса матрицы хватает на то, \r\n\t\tчтобы добиться хорошей картинки как по цвету, так и по яркости и контрасту. Очевидно, что в телевизоре установлена далеко не \r\n\t\tсамая дорогая панель, но и цена устройства соответствующая.</p>\r\n\r\n\t\t<p>К динамическим сценам, которые мы проверили на игровой приставке и запустив пару роликов с активно проводящими время \r\n\t\tперсонажами, претензий не возникло: времени отклика хватало и шлейфов не наблюдалось.</p>\r\n\r\n\t\t<p>Говоря о качестве картинки, нельзя сказать, что все отлично или ужасно. Претензии к изображению есть, но в целом — 7 баллов из 10. \r\n\t\tМешает одно «но»: интерфейс настроек картинки находится… поверх картинки. Да, окно полупрозрачное и не занимает весь экран, но решение спорное.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/013.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/014.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/015.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<h3>Звук</h3>\r\n\r\n\t\t<p>Телевизор не имеет встроенного сабвуфера (это все же бюджетная модель) и предлагает лишь пару 8-ваттных динамиков. \r\n\t\tПри настройках по умолчанию звучание напоминает какой-нибудь немолодой телеприемник. «Задрав» басы и поколдовав со \r\n\t\tсредними и высокими частотами в эквалайзере, можно получить более сочное звучание. Но меломаны и киноманы будут недовольны \r\n\t\tв любом случае: без дополнительных динамиков не обойтись.</p>\r\n\r\n\t\t<h3>Пульт</h3>\r\n\r\n\t\t<p>Тут мнения разделились: кому-то пульт показался чрезвычайно неудобным и со странным дизайном, другие же особых \r\n\t\tотличий от ПДУ импортных телевизоров не заметили. Минусы — пульт и интерфейс «дружат» не всегда: на экран выводятся \r\n\t\tсимволы и обозначения, которых нет на ПДУ, что затрудняет пользование им (пример: «Назад» в интерфейсе это «Exit» \r\n\t\tна пульте). Пульт можно перевести в режим «мышки», что подразумевает передвижение курсора кнопками со стрелками по \r\n\t\tвертикали и горизонтали, но удобнее подключить обыкновенного «грызуна».</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/016.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/017.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<h3>Android</h3>\r\n\r\n\t\t<p>Как показали бенчмарки, система базируется на Android 4.4.4 и выдает себя за 9,7-дюймовый планшет с разрешением 720p. \r\n\t\tОперативной памяти откровенно мало — 512 МБ, из которых оказалось свободно около 30 МБ; доступной встроенной памяти — чуть \r\n\t\tбольше гигабайта. За работу отвечает 4-ядерный чип с тактовой частотой 1 ГГц, а поставщиком умной платформы является компания MStar. \r\n\t\tДоработкой «начинки» занимались специалисты «Витязя».</p>\r\n\r\n\t\t<p>Интерфейс понятный, и найти нужную программу или функцию несложно. Но иконки кричат либо о бессилии дизайнеров, \r\n\t\tлибо о том времени, когда тени, выпуклые формы и зеркальные отражения были обязательным атрибутом.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/018.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/019.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/020.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/021.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/022.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/023.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/024.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/025.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/026.jpg" alt="" width="690" height="459" /></p>\r\n\r\n\t\t<p>(Специализированные программы для скриншотов предлагали использовать стандартные сочетания клавиш — кнопки включения и регулятора громкости.)</p>\r\n\r\n\t\t<p>Некоторые встроенные приложения после ошибок вылетали — например, YouTube. Система с трудом справляется с «тяжелыми» сайтами: \r\n\t\tони медленно грузятся и о плавном пролистывании придется забыть. После нажатия на кнопку нужно немного подождать отклика.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/027.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<p>Запустить Skype мы смогли (потребовалось несколько минут), однако пообщаться с кем-либо не удалось — программа вылетела. \r\n\t\tВ устройстве было установлено и несколько приложений, поставляющих видеоконтент на платной и бесплатной основе. С ними сложностей не возникло.</p>\r\n\r\n\t\t<p>В итоге своей работой телевизор напоминает старенький Android-планшет: свои функции он выполняет, но придется запастись терпением, чтобы получить требуемое.<p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/028.jpg" alt="" width="690" height="459" /></p>\r\n\t\t<h3>Выводы</h3>\r\n\r\n\t\t<p>Самое интересное — цена: 42-дюймовый белорусский Android-телевизор обойдется в 6,9 млн рублей, или 699 рублей в новейшей истории. \r\n\t\tЧуть дороже — импортные аналоги от таких брендов, как BBK и Mystery. Есть в каталоге и отечественный «Горизонт», вышедший в 2014 году, \r\n\t\tоднако насколько он отличается от телеприемника «Витязь», мы не знаем. Также не получилось сравнить тестовый телевизор с китайскими \r\n\t\tустройствами в этом же ценовом диапазоне. Ну и остаются «голые» телеприемники без всяких «андроидов» (JVC, LG, Philips и некоторые другие).</p>\r\n\r\n\t\t<p>Очевидный плюс «Витязя» — это белорусский телевизор, поэтому проблем с сервисом и гарантией быть не должно. Вряд ли по своим \r\n\t\tвозможностям он сильно уступает конкурентам (не исключаем, что в чем-то даже превосходит их). Есть претензии к «скрытому» дизайну — \r\n\t\tв частности, задней панели и блоку с кнопками управления. К сборке вопросов нет, а качество материалов оценивать не беремся.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/027.jpg" alt="" width="690" height="459" /></p>\r\n\r\n\t\t<p>Пользоваться возможностями Android если и придется, то лишь в крайнем случае — когда, например, нужно срочно выйти в интернет, \r\n\t\tа ничего другого, кроме телевизора, под рукой нет. Зато владелец сможет оценить блага цивилизации в виде интерактивных телесервисов \r\n\t\t(Megogo, Smart Zala и так далее). Те, кто хочет большего, должны быть готовы заплатить раза в два больше. Прорыв? Нет — скорее начало \r\n\t\tпути, по которому надо скакать галопом и наверстывать упущенное.</p>\r\n\t\t<p><img style="display: block; margin-left: auto; margin-right: auto;" src="/style/images/Vityas_onliner/028.jpg" alt="" width="690" height="459" /></p>', '2017-01-16 22:26:24'),
(3, 1, 1, 2, 2, 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc mauris metus, semper sit amet posuere dapibus, dictum pretium eros. Vestibulum porttitor condimentum nisl at gravida. Donec ante nibh, tempus nec dui non, porta finibus sem. Fusce imperdiet efficitur lobortis. Maecenas condimentum tortor nec pharetra mollis. Aenean sed dolor eu lorem auctor efficitur. Vestibulum aliquet mauris non egestas laoreet. Donec vehicula ultricies sapien eu egestas. Donec tempor gravida nulla, quis egestas lorem imperdiet sit amet. Phasellus consectetur, arcu vel maximus congue, felis ex sollicitudin ligula, vitae tristique sem eros vitae dolor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Phasellus porta tristique magna, ut pretium nunc lobortis eu. Integer sed lacus erat.', '2017-01-13 00:11:03'),
(4, 2, 1, 1, 1, 'Donec ut dapibus nisi, id tempor turpis. Vestibulum eros quam, iaculis sed hendrerit ac, consectetur sed ipsum', 'Vivamus congue velit non massa vulputate auctor. Praesent ut justo eu nulla congue tempus. Vestibulum malesuada ex ut arcu aliquet viverra at eu tortor. Fusce tincidunt convallis tellus eget feugiat. Nulla dapibus massa sit amet malesuada consectetur. Quisque massa metus, tincidunt ut fringilla a, vehicula a ligula. Nulla sed libero pharetra, rutrum tellus ac, lacinia nisi. Nunc sit amet accumsan augue, at imperdiet augue.', '2017-01-16 22:26:28'),
(5, 1, 1, 2, 2, 'Sed turpis leo, egestas vitae dapibus quis, euismod non sapien. Nunc pharetra tincidunt tortor, vitae fermentum diam rhoncus id', 'Etiam ac dolor eu nisi tincidunt pellentesque. Etiam in laoreet magna. Suspendisse eget tempor felis. Mauris elementum felis vel nunc egestas, sed elementum quam euismod. Donec ullamcorper nibh ut felis tempor, nec pretium magna hendrerit. Aliquam a ligula suscipit justo faucibus cursus ac quis enim. Phasellus egestas lacus tellus, ac bibendum enim mollis nec. Sed et varius purus. Sed quis vehicula turpis. Sed ornare venenatis neque non fermentum. Suspendisse egestas malesuada neque, sed malesuada mi placerat volutpat. Donec scelerisque augue sed lorem molestie condimentum. Sed vitae hendrerit lorem, sit amet feugiat neque. Etiam et maximus odio. Nullam posuere justo elit, a ultrices sem pretium consectetur.', '2017-01-13 21:27:40'),
(6, 1, 1, 1, 2, 'Nunc vitae diam et libero blandit pretium quis in purus. ', 'Donec pretium ipsum dolor, quis convallis lorem tempor sollicitudin. Sed efficitur, enim nec vestibulum aliquet, ex justo tempus ex, nec sollicitudin orci nulla ut mauris. Ut feugiat sit amet ligula ac cursus. Suspendisse commodo ex vel mi fermentum pharetra. Quisque porttitor est eu leo scelerisque, sed sagittis enim aliquam. Ut rhoncus justo et sem tempus rhoncus. Mauris ornare porta massa, ut porttitor leo maximus eu.\r\n\r\nCurabitur eget pharetra magna. Etiam iaculis elementum quam sed tristique. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Pellentesque risus sapien, molestie finibus velit interdum, consectetur tempus eros. Ut volutpat velit quam, in vulputate purus aliquet in. Ut euismod purus in massa convallis, at suscipit velit finibus. Integer vitae placerat ligula, quis elementum sem. In id eros porttitor, viverra ipsum a, mattis ligula. Etiam a maximus nisl. Quisque non ante viverra, feugiat nisl quis, dignissim nisi.\r\n\r\nFusce rutrum quis tortor non venenatis. Fusce orci ex, vulputate sed elementum eget, rhoncus nec tortor. Nunc et placerat augue. Maecenas sed ante dictum, auctor nulla sit amet, cursus risus. Phasellus consequat facilisis ante sed pharetra. Etiam sed metus sit amet est convallis mollis. Vestibulum feugiat sit amet enim ac ultricies.\r\n\r\nInteger eget neque sapien. Morbi eros elit, facilisis fermentum orci eget, vehicula pharetra justo. Morbi luctus, lacus et euismod tempus, augue lectus congue ex, iaculis molestie tellus dui vel ante. Proin eu congue neque. Phasellus mauris purus, bibendum sit amet eleifend quis, imperdiet a eros. Integer accumsan quam non mollis lobortis. Suspendisse potenti. Donec venenatis commodo dolor, quis fringilla libero lacinia non. Quisque orci nulla, convallis eu viverra et, iaculis eu est. Pellentesque eu facilisis arcu. Praesent sagittis nibh vel dui rhoncus, eu eleifend ligula placerat. Integer eu mattis ante, quis cursus velit. Fusce congue at dolor id lobortis. Donec accumsan purus eget mi cursus laoreet.\r\n\r\nNunc quam tellus, varius ac massa id, porttitor mattis sem. Sed eleifend mattis feugiat. Etiam laoreet iaculis dignissim. Sed aliquet bibendum tristique. Maecenas tincidunt eros ligula, non luctus dolor blandit eu. Quisque porttitor pharetra erat iaculis fermentum. Nullam vitae nibh gravida, euismod enim ut, malesuada enim. Vestibulum sagittis orci nec lorem viverra hendrerit. Integer quis nulla at sem posuere egestas.\r\n\r\nSuspendisse tempus mauris in magna lobortis, eget pulvinar risus vestibulum. Donec venenatis purus ullamcorper enim ultricies, ut pellentesque mauris imperdiet. Praesent congue massa nibh, eget egestas orci varius aliquet. Ut ut ipsum sit amet magna ullamcorper viverra sed eget libero. Ut sit amet arcu lacus. Aenean mattis in erat et interdum. Donec interdum mi ut urna vestibulum accumsan. Integer pretium augue vel malesuada euismod. Fusce lorem nunc, auctor mattis tellus vitae, fermentum sodales justo. Phasellus aliquam libero vel justo eleifend laoreet. Duis scelerisque orci mollis, pellentesque magna non, cursus libero. Nam augue nunc, laoreet auctor sodales et, fermentum dictum lorem. Maecenas at ex aliquam, blandit diam quis, vehicula est.\r\n\r\nDuis at convallis turpis, sed viverra augue. Aliquam auctor diam ipsum. Morbi vehicula sodales ante sed maximus. Nullam pulvinar condimentum ex, non luctus tortor sagittis nec. Aenean convallis vulputate lorem at luctus. Proin vulputate interdum porta. Cras ligula nisl, suscipit nec pellentesque at, posuere et mauris. Duis elementum facilisis lorem sit amet pulvinar. Suspendisse vulputate, arcu vel fermentum tristique, tortor nibh sagittis ante, eu ultrices velit arcu aliquam risus. Etiam auctor massa at fermentum egestas. Ut et eleifend nisi. Aliquam ullamcorper egestas tincidunt. Nam non metus finibus, porttitor ligula id, scelerisque augue. Phasellus ullamcorper, elit sit amet dignissim convallis, purus est dignissim nunc, eu aliquet diam nisl ac augue. Nulla a accumsan leo.\r\n\r\nAliquam nec ipsum tellus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Proin venenatis lacus non eros pulvinar rutrum. Nullam maximus accumsan turpis. Morbi elementum lorem nibh, eget consequat lorem fringilla sit amet. In tristique non mauris vel ultricies. Vestibulum varius lectus ac nisl aliquam bibendum. Fusce mauris mauris, maximus eget suscipit sit amet, sagittis non orci. Nulla ultrices ultrices diam id pharetra. Suspendisse ac turpis iaculis, congue tellus sed, feugiat nibh. Vivamus mollis convallis tempor. Sed vel nibh varius, suscipit massa nec, eleifend mi. Cras commodo mollis sagittis. Vestibulum ut consequat nisi, et tristique lacus.', '2017-01-13 21:27:08'),
(7, 3, 1, 2, 1, 'Aliquam erat massa, efficitur convallis laoreet quis, fringilla nec velit.', 'Nulla scelerisque erat vitae libero dictum eleifend. Nullam malesuada gravida ornare. Quisque molestie nisi at mattis semper. Nulla aliquet urna id libero condimentum imperdiet. Proin magna leo, congue at ipsum vitae, dignissim lacinia nibh. Proin urna sem, cursus at metus vel, maximus luctus dui. Sed placerat nunc sit amet sapien dignissim convallis. Duis dapibus risus vulputate, ornare libero porttitor, lacinia est. Curabitur dapibus, quam sed porta rhoncus, odio nisl congue sapien, sit amet commodo metus nunc et erat.\r\n\r\nDuis ante mi, tristique sit amet ipsum et, rutrum posuere turpis. Nunc est nisl, convallis vel blandit eget, sollicitudin vitae dolor. Vivamus quis eros dolor. Duis dictum placerat eleifend. Mauris dictum lorem massa, a molestie nibh tempus molestie. Nunc ac nunc eros. Cras non magna vulputate, luctus sem id, pretium massa. Sed aliquet iaculis massa eget consequat. Maecenas id erat a turpis eleifend interdum nec a ex. Quisque a neque vel velit sodales dictum. Nulla posuere est sit amet dignissim sodales. Cras dictum ante in volutpat lobortis. Sed ullamcorper lobortis eleifend. Curabitur iaculis commodo vulputate. Vivamus vel quam in ex pulvinar ornare sed id risus. Donec lorem turpis, aliquet at nisi vitae, luctus hendrerit ipsum.\r\n\r\nDonec nec venenatis metus. Vivamus bibendum ex lorem, quis laoreet ex aliquam nec. Sed rutrum consequat gravida. Nulla porta diam eu leo laoreet accumsan. In quis dui mauris. Praesent at commodo sapien. Nullam sit amet luctus nulla.\r\n\r\nIn tincidunt dolor id vestibulum volutpat. Vivamus fringilla felis eleifend neque semper blandit. Duis interdum sapien quis quam molestie malesuada. Quisque imperdiet gravida leo et volutpat. Vivamus laoreet eleifend erat vitae bibendum. Sed egestas aliquet ante sed rutrum. Fusce blandit a massa imperdiet rutrum. Vivamus in pellentesque tortor. Nunc semper eu ex in accumsan. Vestibulum id convallis purus. Nullam mauris velit, consequat non viverra id, placerat eu turpis. Duis non turpis non arcu blandit semper sed nec urna. Praesent sed elit id risus dignissim sollicitudin a eu est. Praesent eget euismod diam.\r\n\r\nSuspendisse aliquet quam leo. Aliquam elementum nibh et turpis fringilla bibendum. Ut tortor tellus, tristique in lobortis sit amet, dignissim quis dolor. Maecenas tellus urna, convallis sed sodales nec, tincidunt vel erat. Suspendisse placerat vestibulum nisl nec egestas. Fusce in semper lorem. Etiam id libero vel nulla aliquet lacinia eget eu lectus. Sed eget auctor purus.\r\n\r\nCras quis faucibus mi. Sed accumsan interdum turpis et sollicitudin. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; In elementum tortor et dui dignissim eleifend. Proin sodales placerat euismod. Etiam fringilla ultrices felis ut accumsan. Fusce massa nibh, placerat sit amet facilisis at, consequat sit amet arcu. Sed tincidunt lobortis elit, in venenatis massa vulputate nec.\r\n\r\nPraesent efficitur justo magna, sit amet consectetur tellus blandit vel. Nulla facilisi. Vestibulum risus massa, interdum et lectus a, commodo elementum dui. Vestibulum vel dictum orci. Ut placerat lobortis sapien, sit amet condimentum magna tempor ac. Cras viverra augue velit, eget ultrices magna consequat venenatis. Nulla venenatis neque eu massa suscipit sodales. Aliquam posuere ultricies arcu eu suscipit. Integer risus nunc, feugiat non aliquet eu, pretium vel neque.\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sit amet dui vehicula, tempus neque vitae, congue arcu. Ut mattis vel ante a lacinia. Ut vitae turpis non diam sollicitudin tempor et quis nunc. Vestibulum ultrices finibus lacus, a luctus quam scelerisque sit amet. Morbi justo felis, malesuada non lacus at, elementum ullamcorper lacus. Sed consectetur enim vel metus eleifend, eu luctus metus tristique. Nulla et dictum nisl. Pellentesque ultrices nisi sit amet neque tempus facilisis. Morbi est sapien, dignissim vitae volutpat nec, ultrices ut mi. Morbi vitae tortor ac nunc luctus mollis. Aenean at malesuada enim, id rutrum leo. Donec id odio sit amet nisi ultricies viverra eget eget felis. Suspendisse faucibus dapibus ex in tempus.\r\n\r\nNam eget dolor rhoncus sem pharetra tristique. Proin vestibulum congue arcu non sollicitudin. Mauris tincidunt risus eu facilisis feugiat. Morbi sed nisi mi. Donec sit amet purus eu tortor laoreet blandit. Sed rutrum tellus leo, ut vulputate massa placerat vitae. Proin quis maximus diam. Duis non varius neque, vel auctor mauris. Donec sit amet quam elit.\r\n\r\nMaecenas a lobortis dui, eget dictum dolor. Sed mattis facilisis est eu accumsan. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin quis arcu leo. Donec congue magna quis laoreet gravida. Nullam in urna eu ex tempor tristique sit amet nec purus. Morbi pharetra mattis tortor et scelerisque. Nam rhoncus fermentum eros quis luctus. Mauris sit amet metus erat. Ut id velit et lacus fringilla porttitor. Sed tincidunt nisl et urna vulputate, et hendrerit justo consectetur. Curabitur varius auctor urna, non posuere ipsum posuere ac. Pellentesque tempor turpis sit amet nisl sollicitudin rutrum. Maecenas cursus blandit risus a tincidunt. Phasellus tellus ligula, molestie rhoncus commodo a, aliquet quis sem.', '2017-01-16 22:26:31'),
(8, 2, 3, 1, 2, 'Sed ultricies, est et sodales interdum, purus ligula tempus eros, vitae viverra lectus augue eget velit.', 'Sed ultricies, est et sodales interdum, purus ligula tempus eros, vitae viverra lectus augue eget velit. Morbi accumsan at libero a blandit. Vivamus porta nisi lacus. Morbi vel augue eu ipsum porta pharetra. Pellentesque aliquam augue molestie turpis vestibulum, ac accumsan ante accumsan. In libero risus, imperdiet ac mi nec, tempus iaculis lectus. Sed a pretium odio. Ut vitae lacus scelerisque, sodales tortor id, sagittis justo. Sed laoreet malesuada neque sit amet egestas. Praesent eget vehicula ipsum, a elementum ante. Sed a interdum felis. Aenean eget nisl rhoncus, bibendum sapien a, condimentum enim. Quisque nec elit ex. Maecenas at finibus ex, id fringilla turpis. Cras elementum arcu eu leo feugiat tincidunt. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;\r\n\r\nVestibulum placerat porta tortor et molestie. Integer volutpat dui ut quam gravida, vitae sollicitudin quam facilisis. Suspendisse quis purus suscipit, efficitur odio dapibus, dapibus mi. In tristique sem pharetra elit pellentesque sollicitudin. Donec augue justo, hendrerit vitae felis sit amet, sollicitudin aliquam eros. Praesent venenatis, mauris et pellentesque hendrerit, mauris ligula mattis ante, in elementum libero nisl quis ex. Vivamus ultrices est id metus placerat egestas. Nam fermentum lectus ut congue dapibus. Donec interdum accumsan nunc, sit amet placerat est aliquam quis. Praesent cursus arcu aliquet tortor mollis laoreet in vitae nisi. Nulla dictum elit neque, euismod bibendum erat cursus eu. Nunc interdum scelerisque velit, id commodo ex facilisis sit amet. Vestibulum consectetur sollicitudin interdum. Donec mollis nisl eu fermentum pharetra. Fusce a arcu nec mi elementum rhoncus at ut ex.\r\n\r\nMaecenas pretium tristique nulla, ut efficitur lacus mattis a. Etiam vitae nunc vestibulum, facilisis turpis pretium, blandit odio. Nunc eu felis dui. Proin venenatis vestibulum lectus, quis varius metus scelerisque nec. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nunc maximus mattis commodo. Nunc dolor lectus, vulputate sit amet risus quis, porttitor efficitur nibh.\r\n\r\nVivamus finibus efficitur egestas. Donec tincidunt, metus a laoreet facilisis, risus ligula venenatis sapien, eu suscipit ligula quam semper massa. Quisque hendrerit est at tellus pulvinar consectetur. Etiam id facilisis odio, eget cursus eros. Donec tellus ex, luctus a ullamcorper quis, efficitur vel ligula. Quisque tincidunt libero quis erat ultricies auctor. Praesent maximus neque sed felis placerat ornare. Vestibulum pharetra porttitor neque at volutpat.\r\n\r\nCras venenatis odio eu ligula vestibulum, vel fringilla arcu dictum. Cras egestas malesuada est, eget gravida ligula. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam finibus mauris id elementum ornare. Pellentesque bibendum mi eu cursus pulvinar. Proin vitae ex nec ante consectetur lobortis vitae id urna. Duis sit amet mauris sit amet ligula maximus euismod at nec dui. Fusce non tincidunt orci, eget blandit est. Suspendisse vulputate augue ex, fringilla efficitur diam venenatis vel. Suspendisse nec tortor nibh. Donec eu pharetra felis. Morbi vel tortor dignissim, facilisis est a, luctus nisl. Etiam fermentum nisl in vestibulum condimentum.', '2017-01-16 20:26:13'),
(9, 1, 1, 2, 1, 'Maecenas at dolor nibh.', 'Maecenas at dolor nibh. Nam non dui a risus egestas porta. Pellentesque auctor ante sit amet metus bibendum suscipit. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec rutrum dignissim mauris at suscipit. Maecenas vel sem felis. Nullam id ipsum lorem. Suspendisse efficitur justo ut ullamcorper ultricies. Pellentesque vel arcu ut lectus porttitor porttitor a sed leo. Vestibulum eget aliquam dui. Sed maximus dictum odio, ac gravida justo ultricies quis. Aliquam magna ex, maximus ac tellus eu, iaculis aliquet risus. Donec maximus consectetur purus vitae condimentum. Curabitur in euismod neque. Pellentesque quis quam et sem faucibus mattis.\r\n\r\nNam pharetra vitae quam in pretium. Cras dignissim gravida ligula quis porttitor. Etiam nulla justo, luctus a fermentum eleifend, tristique at massa. Interdum et malesuada fames ac ante ipsum primis in faucibus. Mauris non erat nec justo hendrerit imperdiet. Curabitur est libero, laoreet sit amet leo at, sodales semper magna. Suspendisse malesuada nisl sed tempus accumsan. Aliquam sem nisl, accumsan at erat vel, lacinia elementum augue. Sed pellentesque ante non enim tristique feugiat. Morbi eget mauris magna. Suspendisse potenti. Mauris sit amet arcu quis mi imperdiet congue. Aliquam ac turpis ut dolor pharetra pellentesque. Donec dapibus dui et sem pellentesque, non rutrum ipsum imperdiet.\r\n\r\nUt congue, turpis et vehicula pellentesque, dui turpis lobortis arcu, at lacinia tellus tellus eu neque. Aliquam id tempor nunc, vel pharetra nibh. Cras eu accumsan arcu, et tristique purus. Fusce malesuada eu turpis a tincidunt. Fusce sed risus tortor. Integer consequat lacus sed blandit laoreet. Sed suscipit at sapien nec dignissim. Integer suscipit velit et sapien rhoncus commodo. Maecenas at nibh eleifend, interdum urna eu, elementum arcu. In et auctor odio. Nunc tincidunt consequat elit, et viverra justo rhoncus eu.\r\n\r\nVestibulum sagittis lectus iaculis dignissim vulputate. Nam nec lorem sit amet erat pretium tincidunt sit amet ac diam. Duis ut feugiat nibh. Ut ut vehicula ligula. Sed sit amet tortor quis est aliquam porttitor nec sit amet est. Pellentesque sodales, lacus eu scelerisque malesuada, quam sapien venenatis est, a molestie urna quam ut dolor. Duis consequat vel eros a feugiat. Pellentesque sit amet nisi at erat lobortis ullamcorper. In varius egestas venenatis. In sit amet tempor augue, vitae sodales ipsum. Cras enim mauris, cursus vitae rutrum quis, malesuada quis eros. Nunc sit amet tempor purus, vitae sagittis tellus. Suspendisse pretium hendrerit rhoncus.\r\n\r\nUt a suscipit libero. In vulputate nulla velit, auctor mollis turpis placerat vel. Quisque eget tristique purus,a hendrerit erat. Aliquam quis tincidunt sem, at luctus mauris. Duis at enim elit. In porttitor, ipsum vel vestibulum dictum, augue tellus iaculis lectus, sed congue mi ipsum id est. Aenean ex quam, consectetur sed egestas vehicula, scelerisque ac ipsum.', '2017-01-16 22:26:37'),
(10, 2, 2, 2, 1, 'Nam dignissim finibus ligula, in maximus erat fringilla vel.', 'Nam dignissim finibus ligula, in maximus erat fringilla vel. Sed cursus est sed ante malesuada, id rhoncus neque  consectetur. Aenean vel vestibulum metus, vel molestie nulla. Cras non pharetra nisi. Vestibulum tempus metus eu pellentesque porta. Nullam vulputate suscipit ex, et auctor est sagittis maximus. In sagittis fermentum risus id egestas. Nulla feugiat est in nisl maximus malesuada. Aenean nec nibh et elit efficitur pulvinar. Ut enim lectus, elementum ac turpis sit amet, elementum blandit arcu. Nam vulputate pharetra odio ut posuere. Proin blandit vulputate congue. Donec dignissim ipsum condimentum erat interdum accumsan. Curabitur sit amet vehicula lorem. Fusce sagittis mi non velit feugiat dictum. Aliquam gravida lectus in ex pellentesque, placerat tempus justo vulputate.', '2017-01-16 21:21:24'),
(11, 1, 4, 8, 2, 'Morbi vitae ex metus. Quisque dignissim condimentum mauris eu egestas. ', 'Morbi vitae ex metus. Quisque dignissim condimentum mauris eu egestas. Donec auctor ipsum eu pretium gravida. Proin molestie viverra orci, vel vestibulum sem. Nam aliquet elementum tortor tincidunt aliquet. Nulla et eros porttitor, elementum mi at, semper orci. Cras gravida lacus quam, id iaculis felis fringilla non. Morbi sed lorem et ante egestas varius. Mauris id suscipit nisl.\r\n\r\nFusce dui nibh, convallis vel nisl nec, lacinia dictum felis. Duis eu gravida odio, quis porttitor lorem. Sed porta ipsum quis diam molestie accumsan. In non erat in quam rutrum pharetra. Nunc maximus dictum massa, ac elementum metus ullamcorper a. Suspendisse cursus nisl eu posuere porta. Cras nec suscipit urna. In posuere nisl vel eros tristique dapibus. Fusce nulla arcu, elementum non auctor eget, dignissim non enim. Mauris nec enim quis est sagittis finibus. In eleifend felis eu velit mattis, ac commodo metus consequat. Morbi sem leo, pharetra vel sollicitudin quis, mattis laoreet ligula.\r\n\r\nFusce imperdiet rhoncus lorem, ut efficitur enim varius sit amet. Curabitur ultricies, enim id fermentum tincidunt, diam ligula aliquam quam, consequat luctus neque urna nec purus. Vestibulum rutrum ultrices mi, vel fringilla ex placerat non. Donec sed mattis libero. Proin malesuada dapibus magna ut pretium. Nam orci dolor, ultricies eu ligula consequat, vehicula tincidunt nulla. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus eget velit sed neque ornare tempus et eu sapien. Praesent fermentum blandit nibh, vel bibendum urna efficitur quis. Vivamus tortor justo, interdum non pulvinar at, posuere ut neque. Vestibulum ac faucibus augue. Donec quis fringilla ante.\r\n\r\nDonec eleifend nec mi quis gravida. Quisque eu nulla et lectus mattis eleifend quis sed enim. Nullam at tempor sapien, at porttitor metus. Fusce interdum orci a risus elementum, vitae luctus purus condimentum. Phasellus mollis pellentesque bibendum. In ut consequat sem. Cras at orci accumsan, commodo diam id, interdum ipsum. Nam condimentum risus id sapien lacinia fermentum.', '2017-01-16 22:57:54');

-- 
-- Вывод данных для таблицы media
--
INSERT INTO media VALUES
(1, 'preview.jpg', '', 1),
(2, '001-news.png', '', 2),
(3, 'lenovo.png', NULL, 3),
(4, '002-news.png', NULL, 4),
(5, 'tefal2.jpeg', NULL, 5),
(6, 'vacuum.jpeg', NULL, 6),
(7, '003-news.jpg', NULL, 7),
(8, 'lenovo.png', NULL, 8),
(9, '006-news.jpg', NULL, 9),
(10, '004-news.jpg', NULL, 10),
(11, 'tefal2.jpeg', NULL, 11);

-- 
-- Вывод данных для таблицы posts
--
INSERT INTO posts VALUES
(1, 2, 1, 'Amazing review, bro!!!', '2017-01-07 17:55:04'),
(2, 2, 2, 'This text is blowing my mind!', '2017-01-07 17:55:40'),
(3, 2, 1, 'Thats a spirit!', '2017-01-07 19:05:50'),
(4, 1, 11, 'Not bad!', '2017-01-17 22:35:03'),
(10, 2, 11, 'uy tyui 6r iftgj ', '2017-01-20 20:23:25'),
(11, 2, 9, 'fr35 wer q53t', '2017-01-20 20:26:07'),
(12, 2, 9, 'fdsf qwe435445', '2017-01-20 20:26:51'),
(13, 2, 9, ' hrth ruy trh arg ', '2017-01-20 20:28:05'),
(14, 2, 11, 'Amazing article!', '2017-01-20 20:36:44'),
(15, 1, 8, 'Something wrong in this article!??', '2017-01-20 20:40:49'),
(16, 1, 11, 'Tram-pam-pam!', '2017-01-20 20:55:56');

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;