create database pxldb;
\c pxldb

create user secadv with password 'ilovesecurity';
grant all privileges on database pxldb to secadv;
BEGIN;

create table users (id serial primary key, user_name text not null unique, password text not null);
grant all privileges on table users to secadv;

insert into users (user_name, password) values ('pxl-admin', '8865d3f9ef897f6ed7917ae8f5c8309f0d4db09e2302c8053469c9d6a7665b88') ;
insert into users (user_name, password) values ('george', '869c164bbfd87edb53bbfdd8c1368f0565b3afaeb6caa22ab8f6cf34c139da54') ;

COMMIT;
