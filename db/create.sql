CREATE DATABASE throoput;

CREATE TABLE users (
  user_id int NOT NULL UNIQUE AUTOINCREMENT,
  username varchar NOT NULL UNIQUE,
  email varchar NOT NULL UNIQUE,
  password varchar NOT NULL,
  PRIMARY KEY (user_id)
);

CREATE TABLE boards (
  board_id int NOT NULL UNIQUE AUTOINCREMENT,
  board_name varchar NOT NULL,
  owner int NOT NULL,
  PRIMARY KEY (board_id),
  FOREIGN KEY (owner) REFERENCES users(user_id),
  UNIQUE (board_name,owner),
  INDEX (owner)
);

CREATE TABLE board_steps (
  board int NOT NULL,
  order int NOT NULL,
  step_name varchar NOT NULL,
  PRIMARY KEY (board,order),
  FOREIGN KEY (board) REFERENCES boards(board_id),
  UNIQUE (board,step_name),
  INDEX (board)
);

CREATE TABLE roles (
  role_id int NOT NULL UNIQUE AUTOINCREMENT,
  role_name varchar NOT NULL UNIQUE,
  order int NOT NULL UNIQUE,
  PRIMARY KEY (role_id),
);

CREATE TABLE board_users (
  board int NOT NULL,
  user int NOT NULL,
  role int NOT NULL,
  PRIMARY KEY (board,user),
  FOREIGN KEY (board) REFERENCES boards(board_id),
  FOREIGN KEY (user) REFERENCES users(user_id),
  FOREIGN KEY (role) REFERENCES roles(role_id),
  INDEX (board)
);

CREATE TABLE invited_users (
  board int NOT NULL,
  user int NOT NULL,
  role int NOT NULL,
  PRIMARY KEY (board,user),
  FOREIGN KEY (board) REFERENCES boards(board_id),
  FOREIGN KEY (user) REFERENCES users(user_id),
  FOREIGN KEY (role) REFERENCES roles(role_id),
  INDEX (board)
);

CREATE TABLE tasks (
  task_id int NOT NULL UNIQUE AUTOINCREMENT,
  board int NOT NULL,
  author int NOT NULL,
  created timestamp NOT NULL DEFAULT NOW,
  task_name varchar NOT NULL,
  description MEDIUMTEXT,
  estimate enum(1,2,3,5,8,13,22),
  priority enum('emergency','urgent','major','minor','mundane'),
  due_date DATE,
  lead_time_value int,
  lead_time_units enum('days','weeks','months','years'),
  recurrence JSON,
  PRIMARY KEY (task_id),
  FOREIGN KEY (board) REFERENCES boards(board_id),
  FOREIGN KEY (author) REFERENCES users(user_id),
  INDEX (board)
);

CREATE TABLE task_steps (
  task int NOT NULL,
  board int NOT NULL,
  step int NOT NULL,
  user int NOT NULL,
  transition_time timestamp NOT NULL DEFAULT NOW,
  PRIMARY KEY (task,transition_time),
  FOREIGN KEY (task) REFERENCES tasks(task_id),
  FOREIGN KEY (board) REFERENCES boards(board_id),
  FOREIGN KEY (user) REFERENCES users(user_id),
  FOREIGN KEY (board,step) REFERENCES board_steps(board,order),
  INDEX (board),
  INDEX (task)
);

CREATE TABLE task_notes (
  task int NOT NULL,
  author int NOT NULL,
  body MEDIUMTEXT NOT NULL,
  created timestamp NOT NULL DEFAULT NOW,
  PRIMARY KEY (task,created),
  FOREIGN KEY (task) REFERENCES tasks(task_id),
  FOREIGN KEY (author) REFERENCES users(user_id),
  INDEX (task)
);
