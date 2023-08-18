/*
< ��Ÿ �������� >
 1. from���� ����ϴ� ��������
  - �ζ��� ��(inline view)
  - ���� : ���̺��� ũ�Ⱑ ��Ը��̰ų�, ���̺� ���ʿ��� ������ �ʹ� ���� ��,
    ����ϰ��� �ϴ� ��� ���� �����Ͽ� ����� �ٿ��� ����ϰԵǴ� ������ ����.
  - ���� : �������� ���� �������� ������ ����.
*/
-- ���� 1) 10�� �μ����� �ٹ��ϴ� ����� ������ ���
-- ���, �����, �μ���ȣ, �μ���, ������
    
    -- 1�� ��� : 
    select eno, ename, e.dno, dname, loc
    from employee e, department d
    where e.dno = d.dno
    and e.dno = 10;
    
    -- 2�� ��� : from������ ���������� Ȱ�� --> ������ ������.
    select eno, ename, e.dno, dname, loc
    from (select * from employee where dno = 10) e,
         (select * from department) d
    where e.dno = d.dno;
    
    -- 3�� ��� : �ζ��� ���� �������� �������� ������ ���� -> with���� ���.
    with
    e as (select * from employee where dno = 10),
    d as (select * from department)
    select eno, ename, e.dno, dname, loc
    from e,d
    where e.dno = d.dno;
    
    
/*
2. select������ ����ϴ� ��������
 - select������ ���� �ش��ϴ� ����� ����� �� �ֵ��� �ϴ� ���
 - ���� : ������ ������� ����, where���� ������� ����
 - ���� : ���� ��������, �������� ������.

*/

-- ����2) ��� ���̺�� �޿� ���̺��� Ȱ���Ͽ� ����� ���
-- ���, �����, ����, ����, �޿����, �μ���ȣ, �μ���
 -- 1�� ���
    select eno, ename, job, salary, grade, e.dno, dname
    from employee e, department d, salgrade s
    where e.dno = d.dno
    and salary between losal and hisal;
    
 -- 2�� ��� : select������ ����ϴ� ��������
    select eno, ename, job, salary,
    (select grade from salgrade where e.salary between losal and hisal) "GRADE",
    dno,
    (select dname from department where e.dno = department.dno) "DNAME"
    from employee e;
    
    
/*
3. ���߿� ��������
 - ���� ������������ ���ϴ� ���� ���� ���� ��쿡 ���
*/

-- ����3) �μ����� �ְ����� �μ���ȣ, �ְ������� ���
-- 1�� ��� : ������ ��������
    select dno, salary from employee
    where salary in (select max(salary) from employee group by dno);
    
-- 2�� ��� : ���߿� ��������
    select dno, salary from employee
    where (dno, salary) in (select dno, max(salary) from employee group by dno);
    
/*
4. ��ȣ ���� ��������
 - ������������ ���������� ����ϰ�, �ٽ� ���������� ����� ���������� �ǵ����ִ� ���
 - ���� : ����ð��� ���� �ɷ���, ������ ����.
*/

-- ���� 4) ��� ���̺��� ������������ ���� ������ �޴� ����� ������ ���
-- �μ����� ��������, �������� ��������
    select * from employee e1
    where salary > (select min(salary) from employee e2 where e2.dno = e1.dno)
    order by dno, salary;
    
------------
/*
< SQL�� ���� >

1. DCL : Data Control Language, ������ �����
 - ����� ������ ����, ���� �ο��� ȸ�� ...
 - grant, revoke ...

2. DDL : Date Definition Language, ������ ���Ǿ�
 - ���̺��� ������ ���� ����, ���ſ� ���Ǵ� ��ɾ�
 - create, alter, drop ...

3. DML : Date Mainpulation Language, ������ ���۾�
 - �������� �߰�, ����, ������ ���Ǵ� ��ɾ�
 - select, insert, update, delete ...
 
< ���̺� �̸� ���ϴ� ��Ģ > 
 1. ������, �ѱ�, ����, Ư����ȣ($, #, _) ��� ����
 2. ���ڴ� ù���ڷδ� ��� �Ұ�
 3. ������ ��� �Ұ�
 4. 30Byte���� ��� ����. (����� 30����, �ѱ��� 15����(express ������ 10����))
 5. ���� �������� ���� �̸��� ���̺��� ��� �Ұ�
 6. ������ ��� �Ұ�
  - ���� ����
  - ���̺��� ��Ȯ�ϰ� �� ���� ����
  - �ѱ��� ������� �ʴ� ���� ����
  - Ư����ȣ�� _�� ����� ���� ����
  
< �÷� �̸� ���ϴ� ��Ģ >
1. ������, �ѱ�, ����, Ư����ȣ($, #, _) ��� ����
2. ������ ��� �Ұ�
3. 30Byte���� ��� ����. (����� 30����, �ѱ��� 15����(express ������ 10����))
4. �� ���̺��� ���� �� �̸��� ��� �Ұ�
5. ������ ��� �Ұ�
 - ���� ����
 - �� �̸��� ��Ȯ�ϰ� �� ���� ����
 - �ѱ��� ������� ���� ���� ����
 - Ư����ȣ�� _�� ����� ���� ����
 - �� �̸��� ù���ڸ� ���ڷ� ��� ����������, �ǵ����̸� ù���ڷ� ���ڸ� ������� �������� ����

*/

-- < ���̺��� �����ϴ� ��� >
-- 1. ���̺� ����
    create table dept (
    dno number(2),
    dname varchar2(14),
    loc varchar2(13)
    );
    
-- 2. ���̺� ���� -> ���̺� ���� 1�� 
 -- ���������� ���
 -- ���̺��� ��� �÷��� ����.
 -- �������� ������� ����.
 -- �����͵� �����.
    create table dept2
    as select * from department;

-- 3. ���̺� ���� 2��
 -- ����1) employee ���̺��� 20�� �μ��� �����͸� eno, ename, ������ 2�� ���� �÷����� ������ ���̺� emp20�� ����
    create table emp20
    as select eno, ename, salary*2 "salary2" from employee where dno = 20;
    
-- 4. ���̺� ���� 3��
-- �����ʹ� �������� �ʰ�, ���̺� ������ ����
    create table dept3
    as select dno, dname from department where 0 = 1;
    
-- < ���̺��� ������ �����ϴ� ��� >
-- ���̺��� ���� : �÷�, ������Ÿ��
-- 1. �÷� �߰�
    alter table emp20 add(birthday date);
    
-- 2. �÷��� ���� ����
    alter table emp20 modify(ename varchar2(20));
    
-- 3. �÷� �̸� ����
    alter table emp20 rename column birthday to b_day;
    
-- 4. �÷� ����
    alter table emp20 drop column ename;
    
-- ���� : ���� Ÿ���� ���� ������ ���� (ū ���̷δ� ���� ����)
    alter table emp20 modify(eno number(6));

-- �Ұ��� : ���� Ÿ���� ���̶� ���� ���̷δ� ���� �Ұ���
    alter table emp20 modify(eno number(2));

-- �Ұ��� : �ٸ� ������ Ÿ�����δ� ���� �Ұ�
    alter table emp20 modify(eno varchar2(6));

-- < ���̺���� �����ϴ� ��� >
    rename emp20 to emp_20;
    
-- < ���̺��� �����ϴ� ��� >
    drop table emp_20;

    
-- < ���̺��� ��� �����͸� �����ϴ� ��� >
-- ���̺��� ������ ���� �ְ�, �����Ϳ� �Ҵ�� ������ ����
-- ���̺��� �������ǰ� ���õ� �ε���, ��, ���Ǿ� ���� �״�� ����
-- truncate : DDL, delete : DML
    truncate table dept2;

-- # ������ ��� ���̺� Ȯ���ϴ� ���
    select * from tab;

/*
< ������ ���� >
 - ����ڿ� �����ͺ��̽� �ڿ��� ȿ�������� ����ϰ� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺��� ����
 - ����ڰ� ������ ������ ���� �����ϰų�, ������ ���� ����.
 
< ������ ������ ���� >
 1. USER_**** : ����� �ڽ��� ������ ������ ��ü�� ���� ���� 
 2. ALL_**** : ����� �ڽŰ� ������ �ο����� ��ü�� ���� ����
 3. DBA_**** : �����ͺ��̽� �����ڸ� ���� ������ ��ü�� ���� ����
 4. V$_**** : �����ͺ��̽� ���� ��ü�� ���õ� ����
 
 1) USER_****
    - ����� �ڽ��� ������ ���̺�, �ε���, �� ���� ��ü�� ���� ������ ����
    - user_tables : ����� ���̺� ���� ����
    - user_views : ����� �信 ���� ����
    - user_indexes : ����� �ε����� ���� ����
    - user_sequences : ����� �������� ���� ����
    
 2) ALL_****
    - ����� �ڽŰ� ����ڰ� ������ �� �ִ� ������ �ο����� ���̺�, �ε���, �� � ��ü�� ���� ������ ����
    - all_tables : ����� ���̺�� ����ڰ� ������ �� �ִ� ���̺� ���� ����

 3) DBA_****
    - �����ͺ��̽� ������ �Ǵ� �ý��� �����ڸ� ������ �� �ִ� ������ ����
    - dba_tables : �����ڰ� ������ �� �ִ� ��� ���̺� ���� ����
*/

 -- ����ڰ� ������ ��� ���̺� ���� Ȯ��
    select * from user_tables;
    select table_name from user_tables;
    
 -- all_tables
    select * from all_tables;
    select owner, table_name from all_tables;
    
 -- dba_tables
    select * from dba_tables;
    select owner, table_name from dba_tables;
    
/*
< DML >
 - ���̺� �����͸� �߰�, ����, �����ϴ� ���
 1. select : �����͸� ��ȸ(�˻�)�ϴ� ���
 2. insert : �����͸� �߰��ϴ� ���
 3. update : �����͸� �����ϴ� ���
 4. delete : �����͸� �����ϴ� ���
 
< Ʈ����� (Transaction) >
 - �������� ����, ����, ������ ���ؼ� ���������� Ȯ���� �ϵ��� �ϴ� ���
 1. commit : Ȯ��, ���������� �����ͺ��̽��� �ݿ�
 2. rollback : �ǵ���, �����ͺ��̽��� �ݿ��ϱ� �� ���·� �ǵ��� 
*/


create table emp
as select * from employee;

create table dept
as select * from department;

-- < ������ ���� >
-- insert into ���̺��(�ʵ��...) values(��...);
    
  -- 1. ���̺� ������ ���� 1��
    insert into emp(eno, ename, job, manager, hiredate, salary, commission, dno)
    values(8000,'JENIFFER', 'YUTUBER', 7839, '2023/01/03', 4500, null, 40);
    commit;
    
 -- 2. ������ ���� 2��
 -- �÷��� ���� ���� �������� ������� �Է��Ѵٸ� �÷����� ������ �� ����.
    insert into emp values(8100,'STELLAR', 'BANKER',7902,'2022/08/08',4000, null, 40);
    commit;
    
 -- 3. ������ ���� 3��
 -- not null�� �ƴ� �÷��� ������ �� ����, 
 -- �߰��ϴ� �÷����� ����ϰ�, ���� ������ �� ����. 
    insert into emp(eno, ename, job) values (8100,'TOM', 'ACTOR');
    commit;

 -- 4. ������ ���� 4��
 -- �÷����� ����ϸ�, ������ �ٲ� ��.
    insert into emp(eno, salary, ename) values(8200, 3500, 'JERRY');
    
 -- 5. ������ ���� 5��
 -- null�� �÷��� ���ؼ� ���� �÷���� ���� �����ϸ� null�� �ڵ����� ���Ե�.
    insert into emp(eno, ename, job, manager, hiredate, salary, dno)
    values(8300,'KIM', 'Maker', 7788, '2022/11/11', 3200, 20);
    commit;
    
-- 6. ������ ���� 6��
-- �ٸ� ���̺��� �����͸� �����Ͽ� ���� -> �÷��� ������ ������ ��ġ�� �� ����
-- ���� ���� ���
    insert into emp select * from employee;
    commit;

select * from emp;

-- < ������ ���� >
-- update ���̺�� set ���泻�� where ����;
-- ����1) dept ���̺��� �μ���ȣ�� 10���� �������� �μ����� 'Programming'���� ����
    update dept set dname = 'PROGRAMMING' where dno =10;
    commit;
    
-- ���� 2) dept ���̺��� �μ���ȣ�� 20���� �������� �μ����� 'MARKETING', �������� 'SEOUL'�� ����
    update dept set loc = 'SEOUL', dname = 'MARKETING' where dno = 20;
    commit;
-- ���� 3) dept ���̺��� 10�� �μ��� �������� 30�� �μ��� ���������� ����
    update dept 
    set loc = (select loc from dept where dno = 30)
    where dno = 10;
    commit;
-- ���� 4) dept ���̺��� 10�� �μ��� �μ���� �������� 40�� �μ��� �μ���� ���������� ����.
    update dept
    set dname = (select dname from dept where dno = 40),
        loc = (select loc from dept where dno = 40)
    where dno = 10;
    commit;

    update dept
    set (dname, loc) = (select dname, loc from dept where dno = 40)
    where dno = 10;
    commit;
    
    insert into dept values(10, 'ACCOUNTING', 'SEOUL');
    insert into dept values(20, 'RESEARCH', 'INCHON');
    insert into dept values(30, 'SALES', 'SEJONG');
    insert into dept values(40, 'OPERATION', 'BUCHON');
    insert into dept values(50, 'INFORMATION', 'BUSAN');
    commit;

-- ����)
-- ���� 5) dept ���̺��� �μ����� 'INFORMATION'���� ����.
    update dept set dname = 'INFORMATION';
    commit;
    
-- < ������ ���� >
-- delete [from] ���̺�� where ��������;
-- ���� 1) dept ���̺��� 10�� �μ��� �����͸� ����
    delete dept where dno =10;
    commit;
    
-- ���� 2) dept ���̺��� 20�� �μ��̸鼭 �μ����� RESEARCH�� �μ��� ����
    delete dept 
    where dno = 20 and dname = 'RESEARCH';
    commit;
-- ���� 3) emp ���̺��� SALES �μ����� �ٹ��� ����� �����͸� ��� ����
    delete emp 
    where dno = (select dno from dept where dname = 'SALES');
    commit;

-- ���� 4) dept ���̺��� ��� �����͸� ����
    delete dept;

/*
< truncate�� delete�� ������ >
1. truncate
 - �׾ƺ��� ��� �����͸� ����, �������� �������� ����
 - DDL ���, commit�� ������� �ʾƵ� ��.
 - where�� ��� �Ұ�

2. delete
 - where���� ����ϸ� ���ǿ� ����
 - where���� �����ϸ� ��� �����͸� ����, �������� ������ ���� ����.
 - DML ���, commit�� ����ؾ� ���� �ݿ�.
*/

-- < DDL, DML Ȯ�� �н� Part.1 >
-- 1. employee ���̺��� �����Ͽ� emp_insert ���̺��� �� ���̺�� ����
    create table emp_insert
    as (select * from employee where 0=1);
    commit;
    select * from emp_insert;

-- 2. emp ���̺� �Ʒ��� �����͸� �߰�
-- 1000,'LEE', 'STUDENT', '2022/05/10', 1700, 230, 10
-- manager�� null
    insert into emp_insert values(1000,'LEE', 'STUDENT', null, '2022/05/10', 1700, 230, 10);
    commit;
    
-- 3. emp���̺� �Ʒ��� �����͸� �߰�.
-- 1100, 'KIM', 'SOLDIER', 3200,20
-- manager�� commission�� null
-- hiredate�� ���÷κ��� 3���� ����
    -- 3-1.
    insert into emp_insert(eno, ename, job, hiredate, salary, dno)
    vlues(1000,'KIM', 'SOLDIER', '2022/05/11', add_months(sysdate, -3), 3200, 20);
    commit;
    
    --3-2. 
    insert into emp_insert values(1000,'KIM', 'SOLDIER',null, '2022/05/11', add_months(sysdate, -3), 3200, null, 20);

-- 4. employee ���̺��� ������ ������ �����Ͽ� emp_copy ���̺��� ����.
    create table emp_copy as select * from employee;
    
-- 5. emp_copy ���̺��� �����ȣ 7788�� ����� �μ���ȣ�� 10������ ����
    update emp_copy set dno = 10 where eno = 7788; 
    
-- 6. emp_copy ���̺��� �����ȣ 7788�� ����� ���� �� �޿��� �����ȣ 7499�� ���� �� ������ ��ġ�ϵ��� ����
    update emp_copy
    set (job, salary) = (select job, salary from emp_copy where eno = 7499)
    where eno = 7788;
    commit;

-- 7. emp_copy ���̺��� �����ȣ 7369�� ������ ������ �ϴ� ����� �μ���ȣ�� 7369 ����� �μ���ȣ�� ����.
    update emp_copy
    set dno =(select dno from emp_copy where eno = 7369)
    where job = (select job from emp_copy where eno = 7369);
    commit;

-- 8. department ���̺��� ������ ������ �����Ͽ� dept_copy ���̺��� �����Ͻÿ�.
    create table dept_copy as select * from department;

-- 9. dept_copy ���̺��� �μ����� RESEARCH�� �μ��� ����
    delete from dept_copy where dname = 'RESEARCH';
    commit;

-- 10. dept_copy ���̺��� �μ���ȣ�� 10���̰ų� 40�� �μ��� ����
    delete from dept_copy where dno in (10,40);
    commit;
    
-- < DDL, DML Ȯ�� �н� Part.2 >
-- 1. employee ���̺��� ������ ������ �����Ͽ� employee2 ���̺��� �����Ͻÿ�.
-- ���, �̸�, ����, �μ���ȣ �÷��� �����ϰ�, �����Ǵ� �÷��� �̸��� e_id, name, sal, d_id�� �����Ͻÿ�.
create table employee2
as (select eno e_id, ename name, salary sal, dno d_id from employee);
commit;

-- 2. employee2 ���̺��� d_id �÷��� �����Ͻÿ�.
alter table employee2 drop column d_id;
commit;

-- 3. employee2 ���̺��� sal �÷����� salary�� �����Ͻÿ�.
alter table employee2 rename column sal to salary;
commit;

-- 4. employee2 ���̺��� name �÷��� ���̸� 20���� �����Ͻÿ�.
alter table employee2 modify(name varchar2(20));
commit;

-- 5. employee2 ���̺� ���� ���ڿ� 15�ڸ��� ���� d_name Į���� �߰��Ͻÿ�.
alter table employee2 add(d_name varchar2(15));
commit;

-- �ڡڡڡڡڡڡڡڡڡڡ�
-- �Ͽ��ϱ��� �̸��Ϸ� ����
-- ���� �� �����Ͽ��� �������ǿ� ���ؼ� ����.
-- ����1) 287~ 289 �������� 5������ �ذ��Ͻÿ�.









    select * from dept;
    



























































    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    