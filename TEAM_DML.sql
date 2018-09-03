select * from teamz;

create table teamz(
team_id varchar2(20) primary key,
team_name varchar2(20) );
insert into teamz values('ateam','����Ƽ��');
insert into teamz values('hteam','��ī��');
insert into teamz values('cteam','������');
insert into teamz values('steam','�����');
drop table member;
select * from member;
create table member(
    mem_id varchar2(20) primary key,
    team_id varchar2(20),
    mem_name varchar2(20),
    mem_ssn varchar2(20),
    roll varchar2(20)
);
alter table member add constraint teamz_fk_team_id
    FOREIGN KEY (team_id) REFERENCES teamz(team_id);
insert into member values('a1','ateam','����','34','����');
insert into member values('a2','ateam','����','35','����');
insert into member values('a3','ateam','����','21','����');
insert into member values('a4','ateam','����','29','����');
insert into member values('a5','ateam','����','25','����');
insert into member values('h1','hteam','����','26','����');
insert into member values('h2','hteam','����','26','����');
insert into member values('h3','hteam','��','27','����');
insert into member values('h4','hteam','���','29','����');
insert into member values('h5','hteam','�ܾ�','26','����');
insert into member values('c1','cteam','������','32','����');
insert into member values('c2','cteam','��ȣ','31','����');
insert into member values('c3','cteam','����','29','����');
insert into member values('c4','cteam','����','23','����');
insert into member values('c5','cteam','����','30','����');
insert into member values('s1','steam','��ȣ','27','����');
insert into member values('s2','steam','����','26','����');
insert into member values('s3','steam','�̽�','29','����');
insert into member values('s4','steam','����','26','����');
insert into member values('s5','steam','����','30','����');

ALTER TABLE MEMBER RENAME COLUMN MEMID TO USERID;
UPDATE teamw SET  roll = 
    case 
        when mem_id like 'a1' then '����' 
        when mem_id like 'h1' then '����' 
        when mem_id like 'c1' then '����' 
        when mem_id like 's1' then '����' 
        else  '����'
    end 
;
select * from teamw;
desc teamw

select (select team_name ����
from teamz
where team_id like z.team_id) ����,
    count(*) "������ ��",
    sum(w.mem_age) "������",
    max(w.mem_age) "������ �ִ�ġ",
    min(w.mem_age) "������ �ּ�ġ",
    avg(w.mem_age) �������
    
    
from teamz z
    join teamw w
        on z.team_id like w.team_id
group by z.team_id
--having avg(w.mem_age) >= 28
order by z.team_id
;     

alter table teamz
rename to project_team;
alter table teamw
rename to member;