use webapp;
create table apis(
    id int not null primary key AUTO_INCREMENT,
    message varchar(255)
);

insert into apis(message) values("hello");