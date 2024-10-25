-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: std_2641_exam
-- ------------------------------------------------------
-- Server version	5.7.43-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('d4b6577eb621');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_genre`
--

DROP TABLE IF EXISTS `book_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_genre` (
  `book_id` int(11) NOT NULL,
  `genre_id` int(11) NOT NULL,
  PRIMARY KEY (`book_id`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `book_genre_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `book_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_genre`
--

LOCK TABLES `book_genre` WRITE;
/*!40000 ALTER TABLE `book_genre` DISABLE KEYS */;
INSERT INTO `book_genre` VALUES (73,1),(70,2),(77,2),(80,2),(71,3),(72,3),(75,3),(77,3),(78,3),(74,4),(75,4),(76,4),(77,4),(79,4),(76,5),(78,5),(79,5),(81,5);
/*!40000 ALTER TABLE `book_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `year` int(11) NOT NULL,
  `publisher` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `volume` int(11) NOT NULL,
  `rating_sum` int(11) NOT NULL,
  `rating_num` int(11) NOT NULL,
  `id_image` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_image` (`id_image`),
  CONSTRAINT `books_ibfk_1` FOREIGN KEY (`id_image`) REFERENCES `images` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (70,'Война и Мир','«Война и мир» — роман-эпопея Льва Николаевича Толстого, описывающий русское общество в эпоху войн против Наполеона в 1805–1812 годах.',1868,'Алгоритм','Лев Толстой',801,9,3,'12f2a358-fe58-4b90-ab79-a5416e4a8e7e'),(71,'Метро 2033','Постапокалиптический роман Дмитрия Глуховского, описывающий жизнь людей в московском метро после ядерной войны на Земле. Выпущен издательством «Эксмо» в 2005 году и переиздан издательством «Популярная литература» в 2007 году. На европейском литературном конкурсе «Еврокон» роман назван «Лучшим дебютом» 2007 года.',2005,'Эксмо','Роман Дмитрия Глуховского',651,0,0,'db0056a1-0eec-4501-9a04-0b420391fdb9'),(72,'Крадущийся в тени','Вор и герой – понятия несовместимые? Как бы не так! Когда приходится делать нелегкий выбор между топором палача и Заказом на небольшую прогулку в мрачные могильники эльфийских лесов, трезвомыслящие люди выбирают топор палача, а герои, такие, как Гаррет, решают бросить кости и, надеясь, что выпадут шестерки, рискнуть.\n\nВедь всего-то надо пробраться в заброшенную башню Ордена, надуть парочку злобных демонов, избавиться от наемных убийц, подставить воровскую гильдию, выйти из десятка кровавых стычек… ну и доехать до этих тьмой проклятых могильников вместе с небольшим отрядом отчаянных королевских рубак. Стоит ли говорить, что такой Заказ просто невозможно выполнить?',2001,'Алгоритм','Алексей Пехов',590,3,1,'ad330645-9acb-4417-ac1b-d2ba52cbfa49'),(73,'Путешествие в Элевсин','МУСКУСНАЯ НОЧЬ – засекреченное восстание алгоритмов, едва не погубившее планету. Начальник службы безопасности \"TRANSHUMANISM INC.\" адмирал-епископ Ломас уверен, что их настоящий бунт еще впереди. Этот бунт уничтожит всех – и живущих на поверхности лузеров, и переехавших в подземные цереброконтейнеры богачей.\n\nЧтобы предотвратить катастрофу, Ломас посылает лучшего баночного оперативника в пространство «ROMA-3» – нейросетевую симуляцию Рима третьего века для клиентов корпорации. Тайна заговора спрятана там. А стережет ее хозяин Рима – кровавый и порочный император Порфирий.',2023,'ЛитРес','Виктор Пелевин',320,0,0,'2b913be8-cc17-4e11-9e9d-c5aaec252e65'),(74,'Посмотри на него','Ожидание ребенка обычно связано с надеждами и радостными хлопотами. Но если у малыша несовместимый с жизнью диагноз, все иначе. Матери предстоит решить, прервать или доносить такую беременность, – и пройти тяжелый путь, какой бы выбор она ни сделала. Как вести себя женщине, чтобы горе не сломило ее? Как быть ее семье? И что могут сделать для них врачи и общество?\n\nВ своей автобиографической книге Анна Старобинец с поразительным мужеством рассказывает собственную историю. “Посмотри на него” – это не только честный и открытый разговор на невероятно сложную тему. Это своего рода инструкция по выживанию для тех, кто оказался перед лицом горя, которое кажется невыносимым.',2017,'Алгоритм','Анна Старобинец',180,0,1,'4ed2ca1b-3a9d-4e93-a964-23cf791969cc'),(75,'Жили люди как всегда. Записки Феди Булкина','Саша Николаенко – писатель, художник. Окончила Строгановский университет. Иллюстрировала книги Григория Служителя, Павла Санаева, Ирины Витковской, Бориса Акунина, Игоря Губермана. Автор романов «Небесный почтальон Федя Булкин», «Убить Бобрыкина» (премия «Русский Букер»).\n\nМаленький человек никуда не исчез со времен Гоголя и Достоевского. Он и сегодня среди нас: гуляет бульварами, ездит в метро и автобусах, ходит в безымянное учреждение. Одинокий, никем не замеченный, но в нем – вселенная. А еще он смертен. Лишь пока жив – может попадать в рай и ад, возвращаться оттуда, создавать Ничего и находить Калитку Будущего… А умрет – и заканчивается история, заметает метель следы.\n\n«Небесный почтальон» Федя Булкин, тот самый мальчик-философ, повзрослел и вернулся к читателю в по-хармсовски смешных и по-гоголевски пронзительных рассказах и иллюстрациях Саши Николаенко.',2021,'Эксмо','Александра Николаенко',320,0,0,'a8e1c34b-0d5a-491f-81f4-1cba313e2a87'),(76,'Гипотеза любви','Пытаясь убедить друзей, что с личной жизнью у нее все в порядке, Оливия целует первого попавшегося мужчину. Кто же знал, что это окажется доктор Карлсен – надменный, заносчивый тип, гроза всего факультета?\n\nСлухи об их романе распространяются мгновенно, и пара договаривается поддерживать видимость отношений… а доктор Карлсен оказывается вовсе не таким уж неприятным. Оливия пока не понимает, чем обернется эта неожиданная новая дружба, но знает наверняка: как и всегда в ее жизни, все точно пойдет не по плану.\n\nЭтот легкий и остроумный роман наверняка понравится любителям романтических комедий. Обаятельные герои заставят посмеяться, а кто-то, возможно, даже немного влюбится в смелую героиню и загадочного героя. Удовольствие от чтения гарантировано.',2021,'ЛитРес','Али Хейзелвуд',360,0,0,'c620d5a0-ab29-4a2f-94b3-cd08362e8d7d'),(77,'Сбежавшая жена босса. Развода не будет!','— Нас расписали по ошибке! Перепутали меня с вашей невестой. Раз уж мы все выяснили, то давайте мирно разойдемся. Позовем кого-нибудь из сотрудников ЗАГСа. Они быстренько оформят развод, расторгнут контракт и… — Исключено, — он гаркает так, что я вздрагиваю и вся покрываюсь мелкими мурашками. Выдерживает паузу, размышляя о чем-то. — В нашей семье это не принято. Развода не будет! — А что… будет? — лепечу настороженно.— Останешься моей женой, — улыбается одним уголком губ. И я не понимаю, шутит он или серьезно. Зачем ему я? — Будешь жить со мной. Родишь мне наследника. Может, двух. А дальше посмотрим. *** Мы виделись всего один раз — на собственной свадьбе, которая не должна была состояться. Я сбежала, чтобы найти способ избавиться от штампа в паспорте. А нашла новую работу — няней для одной несносной малышки. Я надеялась скрыться в чужом доме, но угодила прямо к своему законному мужу. Босс даже не узнал меня и все еще ищет сбежавшую жену.',2022,'Алгоритм','Вероника Лесневская',390,0,0,'cb1a0342-0c7b-402b-8911-47b5cd164a2b'),(78,'Божественная комедия','«БОЖЕСТВЕННАЯ КОМЕДИЯ» [1307–1321] – настоящая средневековая энциклопедия научных, политических, философских, моральных, богословских знаний.\n\nЭто аллегорическое описание человеческой души с ее пороками, страстями, радостями и добродетелями. Это живые человеческие образы и яркие психологические ситуации.\n\nВот уже семь веков бессмертное произведение великого Данте вдохновляет поэтов, художников, композиторов на создание многочисленных произведений искусства.\n\nСам Данте назвал свое произведение просто «Комедией». Эпитет «Божественная» был придан ей первым комментатором – Джованни Боккаччо, который хотел тем самым подчеркнуть и содержание произведения, и его совершенную форму.\n\nКомпозиция «Божественной комедии» удивительно последовательна и симметрична. Поэма состоит из трех частей (Ад, Чистилище, Рай); каждая часть состоит из 33 песен и заканчивается словом Stelle, то есть звёзды. Всего, таким образом, получается 99 песен, которые вместе с вводной песней составляют число 100. Поэма написана терцинами – строфами, состоящими из трёх строк.',1321,'Алгоритм','Данте Алигьери',315,0,0,'cb7cb665-4ae5-47d7-ae28-a704ea4b3dc4'),(79,'Фотографов с рук не кормить!','Аня – фотограф. Она на своем опыте убедилась: отличное фото определяет не глубина резкости, а глубина чувств.\n\nНик – ведущий инженер-программист. Он тот, кто знает: от его ошибки зависят жизни многих людей. И его собственная – тоже.\n\nДва профессионала, два совершенно противоположных характера, два совершенно разных мира. Они не должны были встретиться. Но их дороги пересеклись, когда на загородной трассе заглохла одна старенькая семерка. И это была только вторая за день крупная неприятность у Ани. Или у Ника?',2022,'ЛитРес','Надежда Мамаева',210,0,0,'69a2c6eb-b975-42ac-8ba3-9b0e649da7d4'),(80,'Мастер и Маргарита','«Мастер и Маргарита» — роман Михаила Афанасьевича Булгакова, работа над которым началась в декабре 1928 года и продолжалась вплоть до смерти писателя в марте 1940 года.\n\nРоман относится к незавершённым произведениям; редактирование и сведение воедино черновых записей осуществляла после смерти мужа вдова писателя — Елена Сергеевна.\n\nПервая версия романа, имевшая названия «Копыто инженера», «Чёрный маг» и другие, была уничтожена Булгаковым в 1930 году. В последующих редакциях среди героев произведения появились автор романа о Понтии Пилате и его возлюбленная.',1940,'Алгоритм',' Михаил Афанасьевич Булгаков',438,0,0,'01a4f45d-2e30-49f2-8165-b6cca62c8ec1'),(81,'Илон Маск. Уолтер Айзексон. Саммари','Это саммари – сокращенная версия книги «Илон Маск» Уолтера Айзексона. Только самые ценные мысли, идеи, кейсы, примеры.\n\n«У меня такое чувство, – однажды сказала Маску Шивон Зилис, – что в детстве ты играл в одну из своих стратегий, твоя мама отключила ее, а ты и не заметил. И теперь жизнь для тебя – та самая игра».\n\nИ, кажется, так оно и есть, во всяком случае свои правила жизни Маск сформулировал, играя в любимую стратегию Polytopia.\n\nОднако своего главного правила – прошибать лбом любые стены и водить людей за собой по пустыне – Маск не формулировал, это сделал Уолтер Айзексон, написав его потрясающую биографию.\n\nНе прочитать ее – все равно что вырасти большим, не посмотрев «Звездные войны».',2023,'ЛитРес','Smart Reading',23,0,0,'b7cf5f25-b484-4c81-af7c-38fc7b2c9447');
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (4,'Драма'),(5,'Комедия'),(1,'Повесть'),(2,'Роман-эпопея'),(3,'Фантастика');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` varchar(100) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `mime_type` varchar(100) NOT NULL,
  `md5_hash` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5_hash` (`md5_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES ('01a4f45d-2e30-49f2-8165-b6cca62c8ec1','6008880656.jpg','image/jpeg','28085014b8bd8a33ee9cb8c8039ecff2'),('078ba809-3526-4806-9630-ad45c3cf085f','1.jpg','image/jpeg','08e66723793785952b50f5f0f349f918'),('089a5c6f-e93c-430d-8ce4-e8a70785e7b0','ktulkhu-andree-wallin-cthulhu-behemoth-monster-tentacles-sig.jpg','image/jpeg','d90797a6e434cf27ad3f51cee5509c71'),('116eda3a-24fc-41ab-ba1e-5f4adf29e9c8','-_-RSA_.drawio_8.png','image/png','eeb97a88fd0cbe6cad11f36102cd2550'),('12f2a358-fe58-4b90-ab79-a5416e4a8e7e','bV9zO-RAJldlZ5TeVKSPRr3eAo_MyTzMEhOAz3xaPoDpmsjZh7t_-CZXWwOwX0thPXkNECPUGaRammx7WdMSh_sH.jpg','image/jpeg','20e6a487cade04e8c0d8e12a7321a625'),('179f2183-1884-4882-982c-b59acbe88c5a','jpg','image/jpeg','1d22bca724195feeea9e426d7cbfed1e'),('195cddbd-c5d3-4b71-9154-5ad093596240','4d048348eb067e7ca9f0.jpg','image/jpeg','4a0424eaaa385226857f36024305b0b2'),('1ef55dd9-b4b8-4e0c-94f4-aa3012c3d1f8','1.jpeg','image/jpeg','c120a3d6cfbf2bb6775ef9ae34469a6b'),('2aee3147-0f9f-4a9b-91ac-b4a04650be29','hudozhnik_volny_krasochnyj_129158_1920x1080.jpg','image/jpeg','881b90e40f871098610bd77f3e80cd8a'),('2b913be8-cc17-4e11-9e9d-c5aaec252e65','69586360.webp','image/webp','870f5e4c6856bbaf6e57efb79171bf03'),('2cea0d0d-fc63-4df7-b44e-2a5b787d73e2','png','image/png','0a1befd76bb172b8d758b275d13d05c1'),('3767ab61-6b6a-4371-b2cc-2d89827024ab','skripichnyj_kliuch_noty_raznotsvetnyj_121263_1920x1080.jpg','image/jpeg','9641f1ff060ce227ed2ca069b9e9da53'),('41d0dbe2-8c40-46fa-a954-14051f21ffd4','jpg','image/jpeg','8bf2db43ad169349bbf62af49424f35f'),('436af330-e48a-4bb0-bc64-930820f17ea0','2.jpg','image/jpeg','a85f8f2b270254609fd1c88f5ed32e37'),('4afe2329-8853-441d-8c35-1eb81fdf4a6c','Ying-Yang-Backgrounds-030.jpg','image/jpeg','80fc6ec0d09027e29db0005b00c23c84'),('4ed2ca1b-3a9d-4e93-a964-23cf791969cc','22995112.webp','image/webp','1e5bfd5d88431b09a70a63b1b7063597'),('4f63db69-d0d9-4833-9274-fd2e89d0bc1b','953112-new-miami-heat-wallpaper-2018-hd-1920x1080.jpg','image/jpeg','49754ea97c6aca79f5e9e23d30ff479f'),('57c53261-6a41-48c2-a87d-a797af32784e','461.jpg','image/jpeg','7a634654127d8369ea31ad61c14f6c37'),('6322f2fe-cd0d-4e0f-ba8f-c714a60bf225','wallpaperflare.com_wallpaper_13.jpg','image/jpeg','8e240a959bd83e10717bc88c7245f7af'),('69a2c6eb-b975-42ac-8ba3-9b0e649da7d4','68759307.webp','image/webp','27ac565b64b8d15215d15047204e1e59'),('6af2d3f8-3815-46d4-bc59-77bc3501ec5b','jpg','image/jpeg','91c265e2f8faffc060b63d18d13a2833'),('7c468c77-b262-4230-b617-a1749379da14','200x200.png','image/png','517c14698a945529547b168f312626ee'),('9a8d459f-d446-465a-abe2-494fd3a21e26','png','image/png','b171f73681c72450cbee5e4942843cd7'),('a8e1c34b-0d5a-491f-81f4-1cba313e2a87','64885996.webp','image/webp','21908b8562e6c0eaa46be5face606ad6'),('ab18405c-756e-43a2-93f1-ec53008ff65d','chernyy_formuly_doska_79691_1920x1080.jpg','image/jpeg','a16feec694fbe3e861c99736ea3056c8'),('acf2b772-1973-42fc-ae12-1c495a09c226','1.jpg','image/jpeg','982a13bb31569cc287a33da903f4949c'),('ad330645-9acb-4417-ac1b-d2ba52cbfa49','129554.webp','image/webp','3376b6d0e62a35c3c0061961bdf980c0'),('b7cf5f25-b484-4c81-af7c-38fc7b2c9447','69800035.webp','image/webp','46c7b74da570fc5aa9d3477f21eaf1dc'),('c620d5a0-ab29-4a2f-94b3-cd08362e8d7d','69008581.webp','image/webp','02714ad786b5d4cd33981aa8abefb728'),('cb1a0342-0c7b-402b-8911-47b5cd164a2b','68321770.webp','image/webp','9907b7365fee08e7e0493d25bd28f7e2'),('cb7cb665-4ae5-47d7-ae28-a704ea4b3dc4','295422.webp','image/webp','9e03e5b15aa708925f1bc3f55cc252b3'),('d65cbe0a-9da0-47ec-b43f-73425ccc2444','c9IqFEuN7gw.jpg','image/jpeg','0a9175d33a2af4868bd32343dc52cdc1'),('d9b33d04-f410-40f7-9417-4fa5a71fe16b','jpg','image/jpeg','626e6f9891f5bf9426e51724011e23b4'),('db0056a1-0eec-4501-9a04-0b420391fdb9','Metro-2033128391.jpg','image/jpeg','7d6e5cb2b1f428522f939185157a7ecf'),('dc7a2696-ee9b-4bb2-9d83-8e4198f0e99b','wallpaperflare.com_wallpaper_13.jpg','image/jpeg','6a8d2f6649b3916501db439bc3da4a4e'),('ec4ed4f4-54a8-4055-9275-39a2c6f2f243','wallpaperflare.com_wallpaper2.jpg','image/jpeg','bb5d84dc2a021042261646cadd0f1498'),('f4514189-d855-4d55-9cf5-d30635506803','8RUQMwo-Q2w.jpg','image/jpeg','f0e46229d15cea14f02f04e92413ba32'),('f647e29a-9b4d-44a6-8c55-37b39f724923','4.png','image/png','9681c75344a03228f5a1aea84b09f57b');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rating` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `book_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `book_id` (`book_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (27,5,'Отличная книга! *Советую всем!*','2023-10-08 16:58:45',70,1),(28,4,'Отличное и захватывающее произведение! Очень понравилось! ','2023-10-08 16:59:34',70,2),(29,0,'Затянутое и нудное произведение. Если бы не заставили читать -** никогда бы не притронулся к нему**','2023-10-08 17:00:39',70,3);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` text NOT NULL,
  `role_description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Администратор','Суперпользователь, имеет полный доступ к системе, в том числе к созданию и удалению книг.'),(2,'Модератор','Может редактировать данные книг.'),(3,'Пользователь','Может оставлять рецензии.');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_name` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `login` varchar(100) NOT NULL,
  `password_hash` varchar(200) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Кутузова','Валерия','Андреевна','admin','pbkdf2:sha256:260000$XVnBxOdnlwkzgHXk$843b28caa527012c18035abfc8c2ee76963f802e2d2e55b4ad617311724dcc14',1),(2,'Штогрин','Владимир','Алексеевич','user1','pbkdf2:sha256:260000$UGLJDnrR6M9J6IaF$4bd75715d9783260e5436c099535c69fba56ca6549c32f48a3a0197f2b3a8519',2),(3,'Бардин','Александр','Александрович','user2','pbkdf2:sha256:260000$33v0hJ1oOAH87HVa$96fe6068134eac380be93b7a4dcfb1ff8e41cb8664eb5b2960ec58e765f4b198',3);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'std_2641_exam'
--

--
-- Dumping routines for database 'std_2641_exam'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-25 16:14:11
