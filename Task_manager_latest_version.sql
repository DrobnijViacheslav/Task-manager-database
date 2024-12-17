-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Дек 17 2024 г., 20:34
-- Версия сервера: 8.0.30
-- Версия PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `Task_manager`
--

-- --------------------------------------------------------

--
-- Структура таблицы `activity_points`
--

CREATE TABLE `activity_points` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `category_id` int NOT NULL,
  `points` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `activity_points`
--

INSERT INTO `activity_points` (`id`, `user_id`, `category_id`, `points`, `created_at`) VALUES
(1, 1, 1, 10, '2024-12-08 10:38:45'),
(2, 1, 2, 20, '2024-12-08 10:38:45'),
(3, 2, 1, 15, '2024-12-08 10:38:45');

-- --------------------------------------------------------

--
-- Структура таблицы `Categories`
--

CREATE TABLE `Categories` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Название категории',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Описание категории'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Categories`
--

INSERT INTO `Categories` (`id`, `name`, `description`) VALUES
(1, 'Работа', 'Рабочие задачи'),
(2, 'Личное', 'Личные дела'),
(3, 'Учеба', 'Учебные проекты'),
(4, 'Здоровье', 'Медицина');

-- --------------------------------------------------------

--
-- Структура таблицы `priority_levels`
--

CREATE TABLE `priority_levels` (
  `id` int NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Дамп данных таблицы `priority_levels`
--

INSERT INTO `priority_levels` (`id`, `name`) VALUES
(1, 'низкий'),
(2, 'средний'),
(3, 'высокий');

-- --------------------------------------------------------

--
-- Структура таблицы `Tasks`
--

CREATE TABLE `Tasks` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT 'ID пользователя',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Название задачи',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'Описание задачи',
  `status` enum('в процессе','выполнено','ожидание') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'Статус выполнения',
  `priority` enum('низкий','средний','высокий') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `due_date` date DEFAULT NULL COMMENT 'Срок выполнения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания',
  `priority_value` tinyint GENERATED ALWAYS AS ((case `priority` when _utf8mb4'низкий' then 1 when _utf8mb4'средний' then 2 when _utf8mb4'высокий' then 3 end)) VIRTUAL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Tasks`
--

INSERT INTO `Tasks` (`id`, `user_id`, `title`, `description`, `status`, `priority`, `due_date`, `created_at`) VALUES
(1, 1, 'Закончить отчет', 'Подготовить годовой отчет по продажам', 'в процессе', 'высокий', '2024-12-01', '2024-11-27 08:53:46'),
(2, 1, 'Купить подарок', 'Купить подарок на день рождения', 'выполнено', 'средний', '2024-11-20', '2024-11-27 08:53:46'),
(3, 1, 'Записаться к врачу', 'Записаться на консультацию к терапевту', 'ожидание', 'низкий', '2024-12-10', '2024-11-27 08:53:46'),
(4, 2, 'Составить меню', 'Разработать меню для новогоднего праздника', 'в процессе', 'средний', '2024-12-15', '2024-11-27 08:53:46'),
(5, 2, 'Убраться в квартире', 'Генеральная уборка перед праздниками', 'выполнено', 'низкий', '2024-11-30', '2024-11-27 08:53:46'),
(6, 2, 'Заказать доставку', 'Организовать доставку продуктов', 'ожидание', 'средний', '2024-12-05', '2024-11-27 08:53:46'),
(7, 3, 'Подготовить презентацию', 'Создать слайды для проекта', 'в процессе', 'высокий', '2024-12-20', '2024-11-27 08:53:46'),
(8, 3, 'Позвонить заказчику', 'Уточнить детали контракта', 'выполнено', 'высокий', '2024-11-25', '2024-11-27 08:53:46'),
(9, 3, 'Сдать отчет', 'Сдать квартальный отчет', 'ожидание', 'высокий', '2024-12-01', '2024-11-27 08:53:46');

-- --------------------------------------------------------

--
-- Структура таблицы `Task_Categories`
--

CREATE TABLE `Task_Categories` (
  `task_id` int NOT NULL COMMENT 'ID задачи',
  `category_id` int NOT NULL COMMENT 'ID категории'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Task_Categories`
--

INSERT INTO `Task_Categories` (`task_id`, `category_id`) VALUES
(1, 1),
(8, 1),
(9, 1),
(2, 2),
(4, 2),
(5, 2),
(6, 2),
(7, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `Users`
--

CREATE TABLE `Users` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Имя пользователя',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Электронная почта',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Пароль пользователя',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Users`
--

INSERT INTO `Users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'Иван Иванов', 'ivanov@example.com', 'password 123', '2024-01-01 00:00:00'),
(2, 'Анна Смирнова', 'smirnova@example.com', 'securepass456', '2024-02-01 00:00:00'),
(3, 'Петр Петров', 'petrov@example.com', 'qwerty789', '2024-03-01 00:00:00');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `activity_points`
--
ALTER TABLE `activity_points`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `priority_levels`
--
ALTER TABLE `priority_levels`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `Tasks`
--
ALTER TABLE `Tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Индексы таблицы `Task_Categories`
--
ALTER TABLE `Task_Categories`
  ADD PRIMARY KEY (`task_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Индексы таблицы `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `activity_points`
--
ALTER TABLE `activity_points`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `Categories`
--
ALTER TABLE `Categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `Tasks`
--
ALTER TABLE `Tasks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT для таблицы `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `activity_points`
--
ALTER TABLE `activity_points`
  ADD CONSTRAINT `activity_points_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `activity_points_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Tasks`
--
ALTER TABLE `Tasks`
  ADD CONSTRAINT `tasks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `Task_Categories`
--
ALTER TABLE `Task_Categories`
  ADD CONSTRAINT `task_categories_ibfk_1` FOREIGN KEY (`task_id`) REFERENCES `Tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `task_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
