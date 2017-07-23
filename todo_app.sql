DROP USER IF EXISTS michael;

CREATE USER michael WITH ENCRYPTED PASSWORD 'stonebreaker';

DROP DATABASE IF EXISTS todo_app;

CREATE DATABASE todo_app;

\c todo_app;

CREATE TABLE tasks (
title VARCHAR(255) NOT NULL,
id SERIAL NOT NULL PRIMARY KEY,
description TEXT DEFAULT NULL,
created_at time without time zone NOT NULL DEFAULT NOW(),
updated_at time without time zone DEFAULT NULL,
completed BOOLEAN NOT NULL DEFAULT FALSE
);

ALTER TABLE tasks DROP COLUMN completed;

ALTER TABLE tasks ADD COLUMN completed_at timestamp DEFAULT NULL;

ALTER TABLE tasks
ALTER COLUMN updated_at SET NOT NULL;

INSERT INTO tasks
VALUES ('Study SQL', DEFAULT, 'Complete this exercise', now(), now(), NULL);

INSERT INTO tasks (id, title, description, created_at, updated_at)
VALUES (DEFAULT, 'Study PostgreSQL', 'Read all documentation', now(), now());

SELECT title FROM tasks WHERE completed_at IS NULL;

UPDATE tasks SET completed_at = now() WHERE title = 'Study SQL';

SELECT title, description FROM tasks WHERE completed_at IS NULL;

UPDATE tasks SET title = 'Study SQL' WHERE completed_at IS NULL;

SELECT * FROM tasks ORDER by created_at DESC;

INSERT INTO tasks (id, title, description, created_at, updated_at)
VALUES (DEFAULT, 'mistake 1', 'a test entry', now(), now()),
(DEFAULT, 'mistake 2', 'another test entry', now(), now()),
(DEFAULT, 'third mistake', 'another test entry', now(), now());

SELECT * FROM tasks WHERE title LIKE '%mistake%';

DELETE FROM tasks where title = 'mistake 1';

SELECT title, description FROM tasks WHERE title LIKE '%mistake%';

DELETE FROM tasks where title LIKE '%mistake%';

SELECT * FROM tasks ORDER by title ASC;