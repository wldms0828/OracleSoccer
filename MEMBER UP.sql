
select * from subject; 
ALTER TABLE MEMBER RENAME COLUMN AGE TO SSN;
ALTER TABLE MEMBER MODIFY(SSN VARCHAR2(5));
alter table member drop column SSN;
ALTER TABLE MEMBER ADD(PASSWORD VARCHAR2(20));
INSERT INTO MEMBER (PASSWORD) VALUES ('1');
UPDATE MEMBER SET PASSWORD='1';


alter table teamw rename to member;
ALTER TABLE MEMBER RENAME COLUMN MEM_NAME TO NAME;

rollback;

ALTER TABLE MEMBER DROP CONSTRAINTS TEAMZ_FK_TEAM_ID;

CREATE TA