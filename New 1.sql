select * from tab;
select * from member;

alter table teamz
rename to project_team;
alter table teamw
rename to member;

alter table member rename column mem_age to age;