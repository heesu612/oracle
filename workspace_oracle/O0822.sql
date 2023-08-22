-- ����) ���� 394������ ���� �ذ�

    create table dept_const (
    depto number(2) constraint deptconst_deptno_pk primary key, 
    dname varchar2(14) constraint deptconst_dname_unq unique,
    loc varchar2(13) constraint deptconst_loc_nn not null
    );
    
    create table emp_const(
    empno number(4) constraint empconst_empno_pk primary key,
    ename varchar2(10) constraint empconst_ename_nn not null,
    job varchar2(9),
    etel varchar2(20) constraint empconst_tel_unq unique,
    hiredate date,
    sal number(7,2) constraint empconst_sal_chk check (sal between 1000 and 9999),
    comm number(7,2),
    deptno number(2) constraint empconst_deptno_fk references dept_const
    );
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT_CONST', 'EMP_CONST');
    
    -- ###########
    -- < �������� Ȯ��ȭ �� ��Ȱ��ȭ >
    -- �����Ϳ� ���� Ư���� ó���� �׽�Ʈ�� �������� ���������� ��Ȱ��ȭ�ϰ�, �׽�Ʈ�� ������ �ٽ� Ȱ��ȭ �ϴ� ���
    drop table dept;
    drop table emp;
    create table dept as select * from department;
    create table emp as select * from employee;
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT', 'EMP');
    
    -- 1. dept�� dno�� pk �������� �߰�
    alter table dept
    modify dno constraint dept_dno_pk primary key;
    
    -- 2. emp�� dno�� fk �������� �߰�
    alter table emp
    modify dno constraint emp_dno_fk references dept;
    
    -- 3. emp�� eno�� pk �������� �߰�
    alter table emp
    modify eno constraint emp_eno_pk primary key;
    
    -- 4. emp�� ename�� not null �������� �߰�
    alter table emp
    modify ename constraint emp_ename_nn not null;
    
    -- 5. emp�� salary�� check �������� �߰�
    alter table emp
    modify salary constraint emp_salary_ck check (salary between 500 and 5000);
    
    -- 6. dept�� dname�� unique �������� �߰�
    alter table dept
    modify dname constraint dept_dname_u unique;
    
    -- ename�� not null �������� ����
    insert into emp(eno, ename, dno) values(9000,'KIM',20);
    commit;
    
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP"."ENAME")
    insert into emp(eno, ename, dno) values(9100,null,20);
    
    -- ename�� not null �������� ��Ȱ��ȭ
    alter table emp
    disable constraint emp_ename_nn;
    
    insert into emp(eno, ename, dno) values(9100,null,20);
    commit;
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT', 'EMP');
    
    -- ename�� not null �������� Ȱ��ȭ
    -- ORA-02293: cannot validate (SOL23.EMP_ENAME_NN) - check constraint violated
    alter table emp
    enable constraint emp_ename_nn;
    
    -- ename�� null�� �����͸� ����
    delete emp where ename is null;
    commit;
    
    alter table emp
    enable constraint emp_ename_nn;
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT', 'EMP');
    
-- ######################
-- < salary�� check �������ǿ� ���� ���� >
    update emp
    set salary = salary * 2
    where ename = 'SCOTT';
    
-- salary�� check ���������� ��Ȱ��ȭ
    alter table emp
    disable constraint emp_salary_ck;
    
    update emp
    set salary = salary * 2
    where ename = 'SCOTT';
    commit;
    
-- salary�� check ���������� Ȱ��ȭ
-- RA-02293: cannot validate (SOL23.EMP_SALARY_CK) - check constraint violated
    alter table emp
    enable constraint emp_salary_ck;
    
    update emp
    set salary = salary / 2
    where ename = 'SCOTT';
    commit;
    
    alter table emp
    enable constraint emp_salary_ck;
    
-- < dept���� dname�� unique �������� ���� >
-- ORA-00001: unique constraint (SOL23.DEPT_DNAME_U) violated
    insert into dept values (50, 'SALES', 'SEOUL');
    
-- ename�� unique ���������� ��Ȱ��ȭ
    alter table dept
    disable constraint dept_dname_u ;
    
-- ename�� unique ���������� ��Ȱ��ȭ�ϰ�, ������ ����
    insert into dept values (50, 'SALES', 'SEOUL');
    commit;
    
-- ename�� unique ���������� Ȱ��ȭ
-- ORA-02299: cannot validate (SOL23.DEPT_DNAME_U) - duplicate keys found
    alter table dept
    enable constraint dept_dname_u;

-- �ߺ����� ����
    delete dept where dno = 50;
    commit;
    
-- ename�� unique ���������� Ȱ��ȭ
    alter table dept
    enable constraint dept_dname_u;
    
-- < ���� ���Ἲ�� ���� ���� >
    insert into emp(eno, ename, dno) values(9100,'LEE',30);
    COMMIT;
    
-- ORA-02291: integrity constraint (SOL23.EMP_DNO_FK) violated - parent key not found
    insert into emp(eno, ename, dno) values(9200,'CHOI',50);
    
-- emp ���̺� foreign key�� ��Ȱ��ȭ
    alter table emp
    disable constraint emp_dno_fk;
    
    insert into emp(eno, ename, dno) values(9200, 'CHOI',50);
    commit;
    
-- emp ���̺� dno�� foreign key�� Ȱ��ȭ
-- ORA-02298: cannot validate (SOL23.EMP_DNO_FK) - parent keys not found
    alter table emp
    enable constraint emp_dno_fk;
    
-- dept�� 50�� �μ��� �߰�
    insert into dept values(50 , 'MARKETING', 'SEOUL');
    commit;
    
-- emp ���̺� dno�� foreign key�� Ȱ��ȭ
    alter table emp
    enable constraint emp_dno_fk;
    
    select table_name, constraint_name, constraint_type, status, search_condition from user_constraints
    where table_name in ('DEPT', 'EMP');
    
-- #####
-- < default �ɼ� ����, ���� >
-- default �ɼ� Ȯ��
    select * from user_tab_columns
    where table_name = 'EMP';
    
    select table_name, column_name, data_type, data_default from user_tab_columns
    where table_name = 'EMP';
    
-- default �ɼ��� �߰�
-- salary �÷��� default�� 1000�� ����
    alter table emp
    modify salary default 1000;

-- emp ���̺� ������ ����
    insert into emp(eno, ename, dno) values (9300,'SONG',40);
    commit;
    
-- default �ɼ��� �߰�(����)
-- hiredate �÷��� default���� sysdate�� ����
    alter table emp
    modify hiredate default sysdate;
    commit;
    
-- emp ���̺� ������ ����
    insert into emp(eno, ename, dno) values(9400, 'CHOI', 30);
    commit;
    
-- default �ɼ��� ����(����)
    alter table emp
    modify hiredate default null;
    
-- emp ���̺� ������ ����
    insert into emp(eno, ename, dno) values(9500, 'SONG', 10);
    commit;
    
-- default �ɼ��� ����(����)
    alter table emp
    modify salary default null;

-- emp ���̺� ������ ����
    insert into emp(eno, ename, dno) values(9600,'PARK',30);
    commit;
    
-- ##############
/*
�ڡڡڡڡ�
< ��(View) >
 - �ϳ� �̻��� ���̺� �Ǵ� �並 �̿��Ͽ� �����ϴ� ���� ���̺�
 - ���� �����͸� �������� �ʰ�, ������(select)�� ����Ǿ� ����.
 - �������� ������ ������ ����.

< ���� ���� >
 - ���ȼ� : ���̺��� Ư�� ���� �����ϰ� ���� ���� ���
 - ���� : �ʿ��� ������ �����Ͽ� ����ϰ� ���� ���
 
< ���� ���� >
 1. �ܼ� ��(simple view) 
    - �ϳ��� �⺻ ���̺�κ��� ������ �� 
    - DML ����� ������ �� �ְ�, DML ����� �⺻ ���̺� �ݿ���. 
 2. ���� ��(complex view)
    - �� �� �̻��� �⺻ ���̺�κ��� ������ ��
    - ��������, �׷� ���� ������ ���� DML ����� ���������� ����.
    - distinct, �׷��Լ�, group by, rownum�� ������ ���� ����.
*/

    drop table emp;
    drop table dept;
    create table emp as select * from employee;
    create table dept as select * from department;
    
    alter table dept
    modify dno constraint dept_dno_pk primary key;
    
    alter table emp
    modify dno constraint emp_dno_fk references dept;
    
    alter table emp
    modify eno constraint emp_eno_pk primary key;
    
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');
    
    desc emp;
    select * from emp;
    
    desc dept;
    select * from dept;

-- 1�� : �ܼ� ��
    create view v_emp1
    as
    select eno, ename, dno, job from employee;
    
    select * from v_emp1;
    
    -- �� Ȯ��
    select * from user_views;
    select * from user_views where view_name = 'V_EMP1';
    
-- 2�� : �ܼ� ��
    create view v_emp2(���, �����, �μ���ȣ, ����)
    as
    select eno, ename, dno, job from employee;
    
    select * from v_emp2;
    
-- 3�� : �ܼ� ��
drop view v_emp3;
    create view v_emp3(eno, ename, dno, job)
    as
    select eno, ename, dno, job from employee where job = 'SALESMAN';
    
    select * from v_emp3;
    desc v_emp3;
    
-- 4�� : ���� ��
    create view v_emp4
    as
    select * from employee natural join department;
    
    select * from v_emp4;
    
-- 5�� : ���� ��
    create view v_emp5(eno, ename, job, dno, dname, loc)
    as
    select eno, ename, job, dno, dname, loc from employee natural join department; 
    
    select * from v_emp5;
    
-- 6�� : ���� ��
    create view v_emp6(eno, ename, job, dno, dname, loc)
    as
    select eno, ename, job, dno, dname, loc 
    from employee natural join department
    where dno = 30; 
    
    select * from v_emp6;
    
-- #####
-- < �並 ���� �������� �߰�, ����, ���� 1 - �ܼ� �� >
-- ����1) v_emp3�� ����Ͽ� �����͸� �߰�
    insert into v_emp3 values(8000,'KIM', 30, 'SALESMAN');
    commit;
    
    select * from v_emp3;
    select * from employee;
    
-- ����2) v_emp3�� ����Ͽ� �����͸� ����
-- SALESMAN�� �μ���ȣ�� 40������ ����
    update v_emp3
    set dno = 40
    where job = 'SALESMAN';
    
    select * from v_emp3;
    select * from emp;
    
-- ���� 3) v_emp3�� ����Ͽ� �����͸� ����
-- ������� ALLEN ����� ������ ����
    delete from v_emp3 where ename = 'ALLEN';
    COMMIT;
    
    select * from v_emp3;
    select * from emp;
    
-- < �並 ���� �������� �߰�, ����, ���� - ���� ��  >
-- ����4) v_emp6�� ����Ͽ� �����͸� �߰�
    insert into v_emp6(eno, ename, job) values(9100, 'LEE', 'SALESMAN');
    commit;
    
    select * from v_emp6;
    select * from emp;

-- ����5) v_emp6�� ����Ͽ� �����͸� ����
    update v_emp6
    set job = 'SALESMAN'
    where  ename = 'JAMES';
    commit;
    
    select * from v_emp6;
    select * from emp;

-- ���� 6) v_emp6�� ����Ͽ� �����͸� ����
    delete v_emp6 where ename = 'BLAKE';
    commit;
    
    select * from v_emp6;
    select * from emp;
    

-- ##########
-- < �پ��� �� >
-- ����7) �Ʒ��� ���ǿ� �����ϴ� �� v_emp_salary�� �����Ͻÿ�.
-- �� �μ��� �ѱ޿��� ��ձ޿��� ���ϴ� �並 �����Ͻÿ�.

    truncate table emp;
    desc emp;
    insert into emp select * from employee;
    commit;
    select * from emp;

-- #####
-- �׷� �Լ��� ����� ���� �÷����� �����ϰ�, ���� �÷��� �信�� ��� �Ұ�
-- ���� �÷��� �״�� ��� �Ұ�, �˸��ƽ��� �����Ͽ� ��� ����.
-- �׷��Լ��� ���� �÷����� ���� ��� DML�� ����� �� ����.
    create view v_emp_salary
    as
    select dno, sum(salary) sum_sal, round(avg(salary),2) avg_sal 
    from emp
    group by dno;
    
    select dno, sum(salary), round(avg(salary),2) 
    from emp
    group by dno;
    
    desc v_emp_salary;
    select * from v_emp_salary;

-- ������ �߰�
-- ORA-01733: virtual column not allowed here
    insert into v_emp_salary values(50, 3000, 1000);

-- �� ����
-- �� �����ص� �⺻ ���̺��� ������ ��ġ�� ����.
    drop view v_emp_salary;
    
    select * from user_views;

-- �� ���� ����� ���� �ɼ�
    create or replace view v_emp3
    as
    select eno, ename, dno, job from emp
    where job = 'MANAGER';
    
    select * from v_emp3;

-- 2. create or replace force
-- noforce: �⺻ ���̺��� �������� ������ ���� ���� �Ұ�, �⺻��
-- force: �⺻ ���̺��� �������� �ʾƵ� �並 ����

-- ORA-00942: table or view does not exist
    create or replace view v_emp_noforce
    as
    select eno, ename, job, dno from emp_notable
    where job = 'MANAGER';
    
    -- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.
    create or replace force view v_emp_force
    as
    select eno, ename, job, dno from emp_notable
    where job = 'MANAGER';
    
    select * from user_views;
    
    select * from v_emp_force;

-- �����ߴ� view ���� ����. ���� table => department, employee, dept, emp, salgrade
-- #####
/*
< ���� �������� �߿��� �ɼ�>
1. with check option
 - ���������� where�� �ڿ� ���
 - ���ǿ� ��õ� �̿��� �����ʹ� �߰�, ����, ������ �Ұ��ϵ��� �ϴ� �ɼ�
 - �並 ���ؼ� �����͸� �߰�, ����, ������ �� �ϰ��� ������ �� �� �ֵ��� �ϴ� �ɼ�

2. with read only
 - ���������� where�� �ڿ� ���
 - �並 ���ؼ��� �б⸸ ������.

*/
    create or replace view v_emp1
    as
    select eno, ename, job, dno
    from emp
    where job = 'MANAGER';
    
    desc v_emp1;
    select * from v_emp1;

-- v_emp1 ��� ����(job)�� MANAGER�� ����� ������ Ȯ���ϴ� ��
--> ������ MANAGER�� ����� �����͸� �߰�, ����, �����ϴ� ���� �մ��ϴ�.

-- ������ ����) v_emp1�� ���ؼ� MANAGER�� �ƴ� ����� �Է��� ����
    insert into v_emp1 values(8000, 'KIM', 'CLERK', 40);
    commit;
--> MANAGER�� �ƴ� CLERK�� �߰��ϸ� �߰��� ���������� v_emp1���� �������� �ʰ� emp���� �߰��Ȱ��� Ȯ�� ����.
-- ��> MANAGER�� �߰�, ����, ���� �ǵ���?

    select * from v_emp1;
    select * from emp;

-- MANAGER�� �Է°����� �並 ����
    create or replace view v_emp1
    as
    select eno, ename, job, dno from emp
    where job = 'MANAGER' with check option;

-- MANAGER�� �ƴ� ����� �����͸� v_emp1�� �߰� -> �Ұ�
-- ORA-01402: view WITH CHECK OPTION where-clause violation
    insert into v_emp1 values(8100, 'LEE', 'SALESMAN', 30);

-- MANAGER�� ����� �����͸� v_emp1�� �߰� -> ����
    insert into v_emp1 values(8100, 'LEE', 'MANAGER', 30);
    commit;

-- #####
    create or replace view v_emp2
    as
    select eno, ename, job, salary from emp
    where salary between 1000 and 3000;
    
    select * from v_emp2;
    
    insert into v_emp2 values(8200, 'CHOI', 'ANALYST', 2500);
commit;

-- ������ ����) ������ 1000~3000 ���̰� �ƴ� �����͵� �߰��� ����.
-- v_emp2 ������ 1000~3000 ������ �����͸� Ȯ���ϴ� ��, �������� �߰��� ������ 1000~3000 ������ �����͸� �����ϵ��� �ϴ� ���� �մ�.
    insert into v_emp2 values(8300, 'SONG', 'MANAGER', 3500);
    commit;

-- #####
    create or replace view v_emp2
    as
    select eno, ename, dno, job, salary from emp
    where salary between 1000 and 4000 with check option;

    insert into v_emp2 values(8400, 'PARK', 'MANAGER',3500);
    insert into v_emp2 values(8400, 'PARK', 'MANAGER', 3000);
    COMMIT;
    
-- #####
    create or replace view v_emp3
    as
    select eno, ename, job, dno from emp
    where job = 'MANAGER' with read only;
    
-- �������� �߰� �Ұ�
-- SQL ����: ORA-42399: cannot perform a DML operation on a read-only view
    insert into v_emp3 values(8500, 'JUNG', 'MANAGER', 10);

-- �������� ���� �Ұ�
-- SQL ����: ORA-42399: cannot perform a DML operation on a read-only view
    update v_emp3
    set dno=40
    where job = 'MANAGER';

-- �������� ���� �Ұ�
-- SQL ����: ORA-42399: cannot perform a DML operation on a read-only view
delete v_emp3 where job = 'MANAGER';

/*
< �ζ��� �� >
 - inline view
 - create�� ���ؼ� view��� ��ü�� �����ϴ� ���� �ƴ϶�, SQL������ ��ȸ������ ���� ����ϴ� ��
 

 < pseudo column(�ǻ� �÷�) >
  - ������ ���������� ������, Ư���� ������ ���ؼ� �������� ���� �Ͻ����� �÷�.
  
 < rownum >
  - ��ȸ�� �࿡ ���ؼ� �Ϸù�ȣ�� �ٿ��ִ� �ǻ� �÷�.
  - �����͸� �߰��� �� �ű�� �Ϸù�ȣ�̹Ƿ�, order by�� �ص� ������ �Ϸù�ȣ�� �״�� �����ϴ� Ư���� ����.
*/

-- ��ȸ�� �࿡ ���ؼ� rownum���� �Ϸù�ȣ�� �ٿ���.
    select rownum, e.* from emp e;
    
-- ������) ������ ������ rownum�� �ݿ����� ����.
    select rownum, e.* from emp e
    order by salary desc;

-- �ذ�å) �ζ��� �並 ����Ͽ� ������ ����� rownum�� �ݿ��ǵ��� ��.
    select rownum , e.* from (select * from emp e order by salary desc) e;

-- ����) ��ȸ�� �Ǽ� �߿��� ���� 3�Ǹ� �����Ϸ���
 -- 1�� ���
    select rownum , e.* 
    from (select * from emp e order by salary desc) e
    where rownum <= 3;
    
 -- 2�� ���
    with e as (select * from emp e order by salary desc)
    select rownum , e.* 
    from e
    where rownum <= 3;

-- ###################
/*
< ������ > sequence
 - �ڵ����� �����Ǵ� ������ �Ϸù�ȣ
 - ���̺� �⺻Ű�� ������ �÷��� ���� ������ �� �ַ� ���.
 - ex) ��ǰ ��ȣ, �Խ��� ��ȣ ...

create sequence �������̸� 
start with ���۹�ȣ, �����ϸ� �⺻�� 1
increment by ������, �����ϸ� �⺻�� 1
maxvalue �ִ밪 --> �������� �⺻�� 10�� 27��, �������� �⺻�� -1
minvalue �ּҰ� --> �������� �⺻�� 1, �������� �⺻�� -10�� 26��
cycle | nocycle --> �������� ���� �ִ밪�� �Ѿ�� �� ��, cycle �ٽ� ó������ ����, nocycle�� ���� �߻�, �⺻�� nocycle
cache ĳ�ð� | nocache --> ĳ�ø� ����ϴ����� ����, �⺻���� 20

--> 
*/

-- ������ ����, 10���� �����ؼ� 10�� �����ϴ� ������
    create sequence test_seq start with 10 increment by 10;
       
-- ������ Ȯ��
    select * from user_sequences;

-- �������� ���ο� �� ����
    select test_seq.nextval from dual;

-- �������� ���� �� Ȯ��
    select test_seq.currval from dual;

-- ������ ����
    drop sequence test_seq;

-- �������� ����� ���̺� ����
    create table dept1 (
    dno number(2) constraint dept1_dno_pk primary key,
    dname varchar2(20),
    loc varchar2(30)
    );

    desc dept1;
    select * from dept1;

-- dept1 ���̺��� dno���� ����� �������� ����
-- 10���� �����ؼ� 10�� ����
    create sequence dept1_seq start with 10 increment by 10;
    
    select * from user_sequences;

-- ������ ���
    insert into dept1 values(dept1_seq.nextval, 'ACCOUNTING', 'NEW YORK');
    commit;
    insert into dept1 values(dept1_seq.nextval, 'RESEARCH', 'DALLAS');
    COMMIT;
    insert into dept1 values(dept1_seq.nextval, 'SALES', 'CHICAGO');
    COMMIT;
    insert into dept1 values(dept1_seq.nextval, 'MARKETING', 'SEOUL');
    COMMIT;
    
    select * from user_sequences;
    select dept1_seq.currval from dual;
    
-- ������ ���� - dept1_seq�� �������� 5�� ����
    alter sequence dept1_seq
    increment by 5;

-- ���۹�ȣ ������ ������ �Ұ�
-- ORA-02283: cannot alter starting sequence number
    alter sequence dept1_seq
    start with 40;
    
-- ORA-02283: cannot alter starting sequence number
    alter sequence dept1_seq
    start with 1000;
    
-- ������ ����
-- �������� �����ص� �������� ���� ������� ���� �������� ����.
    drop sequence dept1_seq;
    
    select * from dept1;

-- ##########
/*
< �ε��� > index
- ���̺��� �˻� �ӵ��� ����Ű�� ���ؼ� ���̺��� �÷��� ����ϴ� ��ü.
- ���̺��� Ư�� ���� �ּ�, ��ġ ���� ���� ������� ����� ���� ��.
- ����Ŭ���� �ڵ����� ����� ����ϴ� �ε����� ����ڸ� ����� ����ϴ� �ε����� ������.
- �⺻Ű(primary key)�� ����Ű(unique)�� �ڵ����� �ε����� ����
- ���󵵰� ���� �÷��� �ε����� �����ϰ� �Ǹ�, ������ �˻� ������ ���ϸ� �߱��� �� �ִ�.

< �ε����� ���� - ������ ���� ���� >
 - ���� �ε��� : �⺻Ű�� ����Űó�� ������ ���� ���� �÷��� �����ϴ� �ε���
 - ����� �ε��� : �ߺ� �����͸� ����ϴ� �÷��� �����ϴ� �ε���

< �ε����� ���� - �÷��� ������ ���� �з� >
 - ���� �ε��� : �� ���� �÷����� ������ �ε���
 - ���� �ε��� : �� �� �̻��� �÷����� ������ �ε���
 
< ��Ÿ �ε��� >
 - �Լ� ��� �ε��� : �Լ��� ���Ŀ� �����ϴ� �ε���
*/

-- �ε��� Ȯ�� 1
    select * from user_indexes;
    
-- �ε��� Ȯ�� 2
    select * from user_ind_columns;

    drop table emp;
    drop table dept;
    create table emp as select * from employee;
    create table dept as select * from department;
    alter table dept modify dno constraint dept_dno_pk primary key;
    alter table emp modify dno constraint emp_dno_fk references dept;
    alter table emp modify eno constraint emp_eno_pk primary key;
    
    select * from user_indexes where table_name in('EMP', 'DEPT');
    
-- ���� �ε��� ����
-- dname�� ������ ���� ������ ������ ����
    create unique index idx_dept_dno on dept(dname);
    
-- ORA-01452: cannot CREATE UNIQUE INDEX; duplicate keys found
-- job�� ������ ���� ������ �÷��� �ƴϱ� ������ ���� �ε��� ���� �Ұ�
    create unique index idx_emp_job on emp(job);

-- �ε��� ���� 
    drop index idx_dept_dno;
    
-- ����� �ε��� ����
    create index idx_emp_job on emp(job);
    
    select * from user_indexes where table_name in('EMP', 'DEPT');
    select * from user_ind_columns where table_name in ('EMP', 'DEPT');
    
-- ���� �ε��� ����
    create index idx_dept_comp on dept(dname, loc);
    
-- �Լ� ��� �ε��� ����
-- �Լ��� ���Ŀ� �ε��� ����
    create index idx_salary_month on emp(salary/12);
    

    
    
    
    