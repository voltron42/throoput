-- sign_up
insert into users (username,email,password) values (?,?,?);

-- verify user availability
select count(*)
from users
where username = ?;

-- verify email availability
select count(*)
from users
where email = ?;

-- sign_in
select count(*)
from users
where (? = username
or ? = email)
and password = ?;

-- list owned boards
select board_id, board_name
from boards
where owner = ?;

-- Create new board
insert into boards (board_name, owner) values (?,?);

-- list roles
select * from roles order by perm;

--list member boards
select b.board_id, b.board_name, r.role_name, r.order
from boards b
inner join board_users u
on b.board_id = u.board
inner join roles r
on u.role = r.role_id
where u.user = ?;

--List users for board
select u.username, u.email, r.role_name, r.order
from board_users b
inner join users u
on b.user = u.user_id
inner join roles r
on u.role = r.role_id
where b.board = ?;

--invite user
insert into invited_users (board,user,role)
  values (?,?,?);

--confirm invited user
insert into board_users (board,user,role)
  select board, user, role
  from invited_users
  where board = ? and user = ?;
delete from invited_users
  where board = ? and user = ?;

--disinvite users
delete from invited_users
  where board = ? and user = ?;

--remove user from board
select min(role_id) from roles;
update from board_users
  set role = ? - 1;

--list board steps
select step_name, step_order
from board_steps
where board = ?
order by step_order;

--list backlog
select task_id, task_name, estimate, priority, due_date, lead_time_value, lead_time_units
from tasks
where task_id not in (select task from task_steps)
and board = ?;

--list taskboard
select t.task_id, t.task_name, t.estimate, t.priority,
t.due_date, t.lead_time_value, t.lead_time_units,
b.order, b.step_name
from tasks t
inner join task_steps s
on (t.task_id = s.task)
inner join (select task, max(transition_time) as max_transition_time
from task_steps) m
on (s.task = m.task)
and s.transition_time = m.max_transition_time
inner join board_steps b
on (s.board = b.board
and s.step = b.order)
where t.board = ?;

--get task
select * from tasks where task_id = ?;

--get task history
select b.step_name, b.order, u.username, t.transition_time
from task_steps t
inner join board_steps b
on (t.board = b.board
and t.step = b.order)
inner join users u
on u.user_id = t.user
where task = ?
order by t.transition_time;

--get task notes
select n.body, n.created, u.username
from task_notes n
inner join users u
on n.author = u.user_id
where n.task = ?
order by n.created;

--add note
insert into task_notes (task, author, body) values (?,?,?);

--move task
insert into task_steps (task, board, step, user)
  (select task, board, ?, ?
   from tasks
   where task = ?);

--create task
insert into tasks
  (task_name, board, author, description, estimate, priority, due_date, lead_time_value, lead_time_units, recurrence)
  values
  (?,?,?,?,?,?,?,?,?,?);

--edit task
update tasks
  set (task_name = ?,
       description = ?,
       estimate = ?,
       priority = ?,
       due_date = ?,
       lead_time_value = ?,
       lead_time_units = ?,
       recurrence = ?)
  where task_id = ?;

--delete task
delete from tasks where task_id = ?;
delete from task_steps where task = ?;
delete from task_notes where task = ?;

--delete board
delete from task_notes
  where task in (select task_id
    from tasks where board = ?);
delete from task_steps where board = ?;
delete from tasks where board = ?;
delete from invited_users where board = ?;
delete from board_users where board = ?;
delete from board_steps where board = ?;
delete from boards where board_id = ?;

-- delete user
delete from task_notes
  where task in (select t.task_id
    from tasks t
    inner join boards b
    on t.board = b.board_id
    where b.owner = ?);
delete from task_steps
  where task in (select t.task_id
    from tasks t
    inner join boards b
    on t.board = b.board_id
    where b.owner = ?);
delete from tasks
  where board in (select board_id
  from boards where owner = ?);
delete from invited_users where user = ?;
delete from board_steps
  where board in (select board_id
  from boards where owner = ?);
delete from boards where owner = ?;

select min(role_id) from roles;
update from board_users
    set role = ? - 1
    where user = ?;

insert into deleted_users (user) values (?);
--do NOT delete users from user table, just

-- reinstate user
delete from deleted_users where user = ?;

-- stats: ?
