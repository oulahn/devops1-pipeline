use webapp;
create table apis(
    id int not null primary key AUTO_INCREMENT,
    message varchar(255)
);

insert into apis(message) values("hello");
insert into apis(message) values("how are you");
insert into apis(message) values("i am fine");