select * from teamz;

create table teamz(
team_id varchar2(20) primary key,
team_name varchar2(20) );
insert into teamz values('ateam','����Ƽ��');
insert into teamz values('hteam','��ī��');
insert into teamz values('cteam','������');
insert into teamz values('steam','�����');

select * from teamw;
drop table teamw;
create table teamw(
    mem_id varchar2(20) primary key,
    team_id varchar2(20),
    mem_name varchar2(20),
    mem_ssn varchar2(20),
    roll varchar2(20));
alter table teamw add constraint teamz_fk_team_id
    FOREIGN KEY (team_id) REFERENCES teamz(team_id);
insert into teamw values('a1','ateam','����','34','����');
insert into teamw values('a2','ateam','����','35','����');
insert into teamw values('a3','ateam','����','21','����');
insert into teamw values('a4','ateam','����','29','����');
insert into teamw values('a5','ateam','����','25','����');
insert into teamw values('h1','hteam','����','26','����');
insert into teamw values('h2','hteam','����','26','����');
insert into teamw values('h3','hteam','��','27','����');
insert into teamw values('h4','hteam','���','29','����');
insert into teamw values('h5','hteam','�ܾ�','26','����');
insert into teamw values('c1','cteam','������','32','����');
insert into teamw values('c2','cteam','��ȣ','31','����');
insert into teamw values('c3','cteam','����','29','����');
insert into teamw values('c4','cteam','����','23','����');
insert into teamw values('c5','cteam','����','30','����');
insert into teamw values('s1','steam','��ȣ','27','����');
insert into teamw values('s2','steam','����','26','����');
insert into teamw values('s3','steam','�̽�','29','����');
insert into teamw values('s4','steam','����','26','����');
insert into teamw values('s5','steam','����','30','����');

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