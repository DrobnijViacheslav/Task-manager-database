-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Ноя 26 2024 г., 18:40
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
-- База данных: `task_manager`
--

-- --------------------------------------------------------

--
-- Структура таблицы `Categories`
--

CREATE TABLE `Categories` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Название категории',
  `description` text COLLATE utf8mb4_general_ci COMMENT 'Описание категории'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Categories`
--

INSERT INTO `Categories` (`id`, `name`, `description`) VALUES
(1, 'Работа', 'Рабочие задачи'),
(2, 'Личное', 'Личные дела'),
(3, 'Учеба', 'Учебные проекты');

-- --------------------------------------------------------

--
-- Структура таблицы `Tasks`
--

CREATE TABLE `Tasks` (
  `id` int NOT NULL,
  `user_id` int NOT NULL COMMENT 'ID пользователя',
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Название задачи',
  `description` text COLLATE utf8mb4_general_ci COMMENT 'Описание задачи',
  `status` enum('to_do','in_progress','done') COLLATE utf8mb4_general_ci DEFAULT 'to_do' COMMENT 'Статус выполнения',
  `priority` enum('low','medium','high') COLLATE utf8mb4_general_ci DEFAULT 'medium' COMMENT 'Приоритет задачи',
  `due_date` date DEFAULT NULL COMMENT 'Срок выполнения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата создания'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Tasks`
--

INSERT INTO `Tasks` (`id`, `user_id`, `title`, `description`, `status`, `priority`, `due_date`, `created_at`) VALUES
(1, 1, 'Сделать отчет', 'Отчет по проекту', 'to_do', 'high', '2024-12-01', '2024-11-26 18:29:41'),
(2, 1, 'Позвонить клиенту', 'Уточнить детали заказа', 'in_progress', 'medium', '2024-11-30', '2024-11-26 18:29:41'),
(3, 2, 'Подготовить презентацию', 'Презентация для конференции', 'to_do', 'low', '2024-12-05', '2024-11-26 18:29:41');

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
(2, 1),
(3, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `Users`
--

CREATE TABLE `Users` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Имя пользователя',
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Электронная почта',
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT 'Пароль пользователя',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата регистрации'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `Users`
--

INSERT INTO `Users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'Иван Иванов', 'ivan@example.com', 'hashed_password_1', '2024-11-26 18:29:41'),
(2, 'Анна Смирнова', 'anna@example.com', 'hashed_password_2', '2024-11-26 18:29:41');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Categories`
--
ALTER TABLE `Categories`
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
-- AUTO_INCREMENT для таблицы `Categories`
--
ALTER TABLE `Categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `Tasks`
--
ALTER TABLE `Tasks`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

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
