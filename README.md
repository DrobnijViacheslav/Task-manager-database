# Task Manager Database

## Описание проекта
Проект представляет собой базу данных для web-приложения учета задач и персональной продуктивности. База данных разработана с использованием MySQL и предназначена для хранения информации о пользователях, задачах и категориях задач. Она поддерживает функционал организации задач с учетом их приоритета, статуса выполнения и категорий, а так же оценки продуктивности.

## Структура базы данных
База данных состоит из следующих таблиц:
1. **Users (Пользователи):**
   Хранит данные о зарегистрированных пользователях приложения, включая имя, email и дату регистрации.

2. **Tasks (Задачи):**
   Хранит данные о задачах пользователей. Каждая задача включает название, описание, статус выполнения, приоритет и срок выполнения.

3. **Categories (Категории):**
   Хранит список категорий, которые можно использовать для группировки задач (например, "Работа", "Личное").

4. **Task_Categories (Связь задач и категорий):**
   Таблица для реализации связи "многие ко многим" между задачами и категориями.

5. **Priority_levels (Уровни приоритета):**
   Таблица, которая содержит возможные уровни приоритета задач.

6. **Activity_points (Баллы продуктивности):**      
   Содержит информацию о баллах продуктивности, которые пользователи получают за выполнение задач.

## Связи между таблицами
- Один пользователь (**Users**) может иметь множество задач (**Tasks**).
- Каждая задача может быть связана с одной или несколькими категориями через таблицу **Task_Categories** (Связь многие ко многим).
- Cвязь по приоритету задачи: priority_levels<->tasks.
- Cвязь для хранения баллов пользователей по различным видам активности: users<->activity_points.

## Схема данных
На схеме в дизайнере PhpMyAdmin связи между таблицами отображаются в виде линий:
- **Users.id → Tasks.user_id** (1:N)
- **Tasks.id → Task_Categories.task_id** (1:N)
- **Categories.id → Task_Categories.category_id** (1:N)

## Тестовые данные
База данных заполнена тестовыми данными, которые включают:
- Два пользователя с разными задачами.
- Несколько задач с различными статусами и приоритетами.
- Несколько категорий, связанных с задачами через таблицу связи.

## Файлы в репозитории
- **`Task_manager_latest_version.sql`** — SQL-скрипт для создания и заполнения базы данных.
- **`shema.png`** — скриншот схемы базы данных, созданной в дизайнере PhpMyAdmin.

