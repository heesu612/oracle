-- < ���� 10�� ���� Ǯ�� >

    create table chap10hw_emp 
    as select * from employee;
    create table chap10hw_dept 
    as select * from department;
    create table chap10hw_salgrade
    as select * from salgrade;
    commit;
-- 1. 
    insert into chap10hw_dept values(50, 'ORACLE','BUSAN');
    insert into chap10hw_dept values(60, 'SQL','ILSAN');
    insert into chap10hw_dept values(70, 'SELECT','INCHEON');
    insert into chap10hw_dept values(80, 'DML','BUNDANG'); 
    commit;
    
-- 2.
    insert into chap10hw_emp values(7201,'TEST_USER1','MANAGER',7566,'2016/01/02',4500,null,50);
    insert into chap10hw_emp values(7202,'TEST_USER2','CLERK',7201,'2016/02/21',1800,null,50);
    insert into chap10hw_emp values(7203,'TEST_USER3','ANALYST',7201,'2016/04/11',3400,null,60);
    insert into chap10hw_emp values(7204,'TEST_USER4','SALESMAN',7201,'2016/05/31',2700,null,60);
    insert into chap10hw_emp values(7205,'TEST_USER5','CLERK',7201,'2016/07/20',2600,null,70);
    insert into chap10hw_emp values(7206,'TEST_USER6','CLERK',7201,'2016/09/08',2600,null,70);
    insert into chap10hw_emp values(7207,'TEST_USER7','LECTURER',7201,'2016/10/28',2300,null,80);
    insert into chap10hw_emp values(7208,'TEST_USER8','STUDENT',7201,'2016/03/09',1200,null,80);
    
    COMMIT;
    SELECT * FROM chap10hw_emp
    order by eno;
    
-- 3.
    update chap10hw_emp
    set dno = 70
    where salary > (select avg(salary) from chap10hw_emp where dno = 50);
    commit;
    
-- 4.
    update chap10hw_emp
    set salary = salary+salayr*0.1, dno = 50
    where hiredate > (select min(hiredate) from chap10hw_emp where dno = 60);
    commit;

-- 5. 
    delete from chap10hw_emp
    where eno in (
    select eno
    from chap10hw_emp e, chap10hw_salgrade s
    where salary between losal and hisal
    and grade = 5
    );
    
    commit;
    
-- < 12�� ����Ǯ�� >
-- 1.
    create table emp_hw(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
    );

-- 2.
    alter table emp_hw add bigo varchar2(20);
    
-- 3. 
    alter table emp_hw modify bigo varchar2(30);

-- 4. 
    alter table emp_hw rename column bigo to remark;
    
-- 5. 
    insert into emp_hw(empno, ename, job, mgr, hiredate, sal, comm, deptno, remark)
    select eno, ename, job, manager, hiredate, salary, commission, dno, null from employee;
    commit;
-- 6.
    drop table emp_hw;

 -------------------
 /*
 Ʈ�����(transaction), ���Ἲ(integrity), �������(constraints)
 
 < Ʈ����� >
  - �������� �߰�, ����, ���� �ÿ� �۾��� �ϰ����� �����ϱ� ���� ��.
  - ���� ������ �۾��� �ϳ��� ������ ó���� �ϴ� ��
  - ���� ���� �۾��� ��� �����ߴٸ� �۾��� �Ϸ�� ���̰�, �߰��� ������ �߻��ߴٸ� ���۵Ǳ� ���� �۾����� 
    �ǵ����� �۾��� �ϰ����� ������ ��.
  - all or nothing
  - commit(Ȯ��), rollback(���), savepoint(�ѹ��� ��ġ�� ����)
  
  ���� ���� - ���� ��ü
  
  --> ����
  ���� ���� ���
  ...
  ... -> ����
  ...
  ���� ���� �Ա�
  --> ����
 */
    drop table emp;
    commit;
    
    create table emp 
    as select eno, ename, job, salary from employee;
    
-- Ʈ����� �۾�
    insert into emp values (9000, 'KIM', 'MANAGER', 5000);
    delete emp where job = 'SALESMAN'; 
    savepoint spl;
    
    insert into emp values(9100,'LEE','SINGER',5500);
    delete emp where job = 'CLERK';
    
    rollback to spl;
    
    commit;
    
    select * from emp;
    
/*
  < ������ ���Ἲ ���� ���� >
  - Data Integrity Constraint Rule
  - ���̺� ��ȿ���� ���� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���ؼ� ���̺��� ������ �� �� �÷��� �����ϴ� 
    ���� ���� ��Ģ.
  - �����Ͱ� �߰�, ����, ������ �� ����Ǵ� ��Ģ
  - not null, unique, primary key, foreign key, check
  
1. not null
 - �÷��� ���� null�� ������ �ʵ��� �ϴ� ���� ����
 
2. unique
 - �÷��� ���� ������ ���� �������� �ϴ� ���� ����

3. primary key, �⺻Ű, ��Ű, PK
 - �÷��� ���� null�� ������ �ʵ��� �ϰ�, ������ ���� ������ �ϴ� ���� ����
 - ���̺��� ���� �����ϴ� ������ �÷��� �ο���.
 - �ε����� ������.
 
4. foreign key, �ܷ�Ű, FK
 - ���̺� ������ ���� ���Ἲ�� �����ϴ� ���� ����
 
# ���� ���Ἲ (Reference Integrity)
 - �θ� ���̺� : �ٸ� ���̺��� �����Ǵ� ���̺� ex) department
 - �ڽ� ���̺� : �ٸ� ���̺��� �����ϴ� ���̺� ex) employee
 - �ڽ� ���̺��� �÷��� �׻� �θ� ���̺��� ������ �����ϵ��� �ؾ� ��.
 - ��� ���̺��� �μ���ȣ �÷��� ���� �׻� �μ� ���̺��� �μ���ȣ �÷��� �����ؾ� ��.
 - �θ� ���̺��� �μ� ���̺��� �μ���ȣ �÷��� �ݵ�� primary key �Ǵ� unique�� �Ǿ�� ��.
 - �ڽ� ���̺��� ��� ���̺��� �μ���ȣ �÷��� �μ� ���̺��� �μ���ȣ �÷��� �����ϴ� foreign key�� �Ǿ�� ��.
 
5. check ���� ����
 -- user_constraints ���̺��� constraint_type �ʵ��� ��
 -- C: not null or check, U: unique, P: primary key, R: foreign key
*/
 -- 1. not null ���� ����
    create table emp1(
    eno number(4) not null,
    ename varchar(10) not null,
    job varchar2(9)
    );
    
    COMMIT;
    
    desc emp1;
    
    insert into emp1(ename, job) values('KIM', 'MANAGER');
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP1"."ENO")
    
    insert into emp1(eno, job) values(1000, 'CLERK');
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP1"."ENAME")
    
    insert into emp1(eno, ename) values(1000, 'KIM');
    COMMIT;

    select * from emp1;

-- 2. unique ��������
    create table emp2(
    eno number(4) unique,
    ename varchar(10) not null,
    job varchar2(9)
    );
    
    insert into emp2(eno, ename, job) values(1000, 'KIM', 'MANAGER');
    insert into emp2(eno, ename, job) values(1100, 'LEE', 'CLERK');
    insert into emp2(eno, ename, job) values(1100, 'PARK', 'SALESMAN');
    -- ORA-00001: unique constraint (SOL23.SYS_C007024) violated
    insert into emp2(eno, ename, job) values(null, 'SONG', null);
    insert into emp2(ename) values('JUNG');
    commit;

-- ����� �������� ������ ����
-- C: not null or check, U: unique, P : primary key
    select * from user_constraints;
    
    select table_name, constraint_name, constraint_type, status 
    from user_constraints
    where table_name = 'EMP2';
    
-- 3. primary key
    -- 3-1. ���������� �̸��� �������� ���� ��� 
    --> ����Ŭ�� SYS_C��ȣ�� ���·� �������� �̸��� ����
    --> ����ڰ� �����ϱ⿡ �����
    
    create table emp3 (
    eno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9)
    );
    
    drop table emp3;
    -- 3-2. ���� ������ �̸��� ����ڰ� �����ϴ� ���
    -- 1) �÷� ������ �����ϴ� ���
    create table emp3(
    emp number(4) constraint emp3_eno_pk primary key,
    ename varchar2(10) constraint emp3_ename_nn not null,
    job varchar2(9)
    );
    
    -- 2) ���̺� ������ �����ϴ� ���
    -- not null�� ���̺� ������ ������ �� ����.
    create table emp3 (
    eno number(4),
    ename varchar2(10) constraint emp3_ename_nn not null,
    job varchar2(9),
    constraint emp3_eno_pk primary key(eno)
    );
    
    select table_name, constraint_name, constraint_type, status
    from user_constraints
    where table_name = 'EMP3';
    
    select table_name, constraint_name, status
    from user_constraints
    where table_name = 'EMP3';
    
    insert into emp3(eno, ename, job) values(1000,'KIM', 'MANAGER');
    insert into emp3(ename) values('KIM');
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP3"."ENO")
    insert into emp3(eno, ename) values(1000,'LEE');
    -- ORA-00001: unique constraint (SOL23.SYS_C007026) violated
    
    COMMIT;
    
-- 4. foreign key
-- �θ� ���̺� : dept ���̺�
-- �ڽ� ���̺� : emp ���̺�
 -- 1. �÷� ����  
    create table dept(
    dno number(4) constraint dept_dno_pk primary key,
    dname varchar2(15),
    loc varchar2(20)
    );
    
 -- 2. ���̺� ����
    create table dept (
    dno number(2),
    dname varchar2(15),
    loc varchar2(20),
    constraint dept_dno_pk primary key(dno)
    );
 
    -- 1. �÷� ���� - ���������� �÷��� ������ �� �Բ� �ִ� ���
    create table emp (
    eno number(4) constraint emp_eno_pk primary key,
    ename varchar2(10) constraint emp_ename_nn not null,
    job varchar2(9),
    dno number(2) constraint emp_dno_fk references dept
    );
    
    DROP TABLE emp;
    -- 2. ���̺� ���� - �÷��� �����ϰ� ����, ���̺��� �������� ���������� �����ϴ� ���
    create table emp (
    eno number(4),
    ename varchar2(10) constraint emp_ename_nn not null,
    job varchar2(9),
    dno number(2),
    constraint emp_eno_pk primary key(eno),
    constraint emp_dno_fk foreign key(dno) references dept
    );
    
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('DEPT', 'EMP');
    
    -- ���� ���Ἲ ����
    insert into dept select * from department;
    commit;
    
    insert into emp(eno, ename, job, dno) values(1000, 'KIM','MANAGER', 20);
    commit;
    
    -- ORA-00001: unique constraint (SOL23.EMP_ENO_PK) violated
    -- primary key ����
    insert into emp(eno, ename, job, dno) values(1000, 'LEE','SALESMAN', 30);
    
    -- ORA-01400: cannot insert NULL into ("SOL23"."EMP"."ENAME")
    -- not null ����
    insert into emp(eno, job, dno) values(1100,'CLERK',10);

    -- ORA-02291: integrity constraint (SOL23.EMP_DNO_FK) violated - parent key not found
    -- ���� ���Ἲ ����
    insert into emp(eno, ename, job, dno ) values(1200, 'SONG', 'SALESMAN', 50);

    -- dept ���̺� 50�μ��� �����ϰ� ����, �ٽ� �׽�Ʈ
    insert into dept values(50,'MARKETING','SEOUL');
    COMMIT;
    
    insert into emp(eno, ename, job, dno) values(1200,'SONG','SALESMAN',50);
    commit;
    
    delete from dept where dno = 10;
    
    -- emp ���̺��� �μ���ȣ�� 10���� �����͸� ��� ������, �ٽ� �׽�Ʈ
    delete from emp where dno = 10;
    
-- 5. check ��������
    create table emp5 (
    eno number(4) constraint emp5_eno_pk primary key,
    ename varchar2(10) constraint emp5_ename_nn not null,
    job varchar2(9),
    salary number(7,2) constraint emp5_salary_c check (salary between 1000 and 3000)
    );

    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name = 'EMP5';
    
    select * from user_constraints
    where table_name = 'EMP5';
    
    insert into emp5 values(1000, 'KIM', 'MANAGER', 2000);
    COMMIT;
    
    -- ORA-02290: check constraint (SOL23.EMP5_SALARY_C) violated
    -- check �������ǿ� ����
    insert into emp5 values(1100, 'LEE', 'CLERK' , 500);

    -- ORA-02290: check constraint (SOL23.EMP5_SALARY_C) violated
    -- check �������ǿ� ����
    insert into emp5 values(1100, 'LEE', 'CLERK', 3100);

-- 
    delete dept where dno = 10;
    
-- 6. default �ɼ�
-- �ƹ����� �Է����� �ʾƵ� �ڵ����� �ԷµǴ� ���� ����
    
    create table emp6 (
    eno number(4) constraint emp6_eno_pk primary key,
    ename varchar2(10) constraint emp6_ename_nn not null,
    job varchar2(9),
    salary number(7,2) default 1000
    );

-- ���� ���� Ȯ��
    select * from user_constraints
    where table_name = 'EMP6';
    
-- default Ȯ��
    select * from user_tab_columns;
    select * from user_tab_columns where table_name = 'EMP6';
    select data_default from user_tab_columns where table_name = 'EMP6';
    
    insert into emp6 values(1000,'KIM','MANAGER',1500);
    COMMIT;
    
    insert into emp6(eno, ename, job) values(1100,'LEE', 'CLERK');
    COMMIT;
    
-- #############
-- < ���� ������ �߰�, ����, ���� >
    drop table emp;
    drop table dept;
    create table emp as select * from employee;
    create table dept as select * from department;
    
    
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMPLOYEE', 'DEPARTMENT');

    -- ���������� ������ �� ����.
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');

    --1. ���������� �߰�
    -- 1-1. dept ���̺� primary key �߰�
    -- �θ� ���� ���������� ���� �߰��ؾ� ��.
    -- 1�� : add constraint�� ���
    alter table dept
    add constraint dept_dno_pk primary key(dno);
    
    -- 2�� : modify��
    alter table dept
    modify dno constraint dept_dno_pk primary key;
    
    -- 1-2. emp ���̺� primary key �߰�
    -- �� ������ �ڽĿ� ���� ���������� �߰���.
    alter table emp
    add constraint emp_eno_pk primary key(eno);
    
    insert into emp(eno, ename, dno) values(9000, 'KIM', 50);
    COMMIT;

-- ��� 1. dept ���̺� 50�� �μ��� �߰�
    insert into dept values(50, 'MARKETING' ,'SEOUL'); 
    COMMIT;
    
-- ��� 2. emp ���̺��� 50�� �μ��� ���� ��� ������ ����
    delete emp where dno =50;
-- 1-3. emp ���̺� foreign key �߰�
-- ORA-02298: cannot validate (SOL23.EMP_DNO_FK) - parent keys not found
    alter table emp
    add constraint emp_dno_fk foreign key(dno) references dept;

-- 2. not null ���� ���� �߰�
-- emp ���̺��� ename �÷��� not null ���������� �߰�
-- not null ���� ������ add constraint ���� ������� ����. -> modify ���� �����.
-- ���� : ��� �Ұ�
    alter table emp
    add constraint emp_ename_nn not null(ename);

    alter table emp
    modify ename constraint emp_ename_nn not null;

-- not null ���� ���� ����
-- ORA-01400: cannot insert NULL into ("SOL23"."EMP"."ENAME")
    insert into emp(eno, ename, dno) values( 8000, null,30);

-- 3. not null�� null�� ����
    alter table emp modify ename null;

-- �������� Ȯ��
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');

-- 4. unique ���� ���� �߰�
-- emp ���̺� ename�� unique ���� ���� �߰�
-- 1��
    alter table emp
    add constraint emp_ename_u unique(ename);

-- 2��
    alter table emp
    modify ename constraint emp_ename_u unique;
-- unique ���� ���� ����
    insert into emp(eno, ename, dno) values(9100, 'LEE', 10);
    commit;
    -- ORA-00001: unique constraint (SOL23.EMP_ENAME_U) violated
    insert into emp(eno, ename, dno) values(9200,'LEE',20);

    insert into emp(eno, ename, dno) values(9300,null,30);
    commit;
    insert into emp(eno, ename, dno) values(9400,null,40);
    commit;

-- 5. check ���� ���� �߰�
-- emp ���̺� salary�� check ���� ���� �߰�
-- 1��
    alter table emp
    add constraint emp_salary_ck check (salary between 1000 and 3000);

-- 2��
    alter table emp
    modify salary  constraint emp_salary_ck check (salary between 1000 and 3000);
    
-- check �������� ����
    insert into emp(eno, ename, salary, dno) values(9500,'CHOI',3000, 40);
    COMMIT;
    -- ORA-02290: check constraint (SOL23.EMP_SALARY_CK) violated
    insert into emp(eno, ename, salary, dno) values(9600, 'PARK',3500,20);
    
    --ORA-02290: check constraint (SOL23.EMP_SALARY_CK) violated
    update emp
    set salary = 4000
    where job = 'SALESMAN';

-- �������� Ȯ��
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');

-- #################
-- < ���� ������ �̸� ���� >
    alter table emp
    rename constraint emp_ename_u to emp_ename_uq;
    
-- < ���� ������ ���� >
-- ORA-02264: name already used by an existing constraint
-- ���� ������ �����ϰ�, ����� ���������� �ٽ� ������.
    alter table emp
    modify salary constraint emp_salary_ck check (salary between 500 and 5000);

-- < ���� ������ ���� >
    alter table emp drop constraint emp_salary_ck;
    alter table emp drop constraint emp_ename_uq;

-- < ���� ���Ἲ�� ���� >
-- �ڽ� ���̺��� ���������� ���� �����ϰ�, �θ� ���̺��� ���������� ������.

-- ORA-02273: this unique/primary key is referenced by some foreign keys
    alter table dept drop constraint dept_dno_pk;

-- 1�� : emp ���̺��� fk�� ���� ����
    alter table emp drop constraint emp_dno_fk;
    alter table emp drop constraint emp_eno_pk;

-- 2�� : �� ������ dept ���̺��� pk�� ���� 
    alter table dept drop constraint dept_dno_pk;

-- < ���� ���Ἲ�� �������� �ο� >
-- 1. dept�� dno�� PK �߰�
    alter table dept
    modify dno constraint dept_dno_pk primary key;

-- 2. emp�� eno�� PK �߰�
    alter table emp
    modify eno constraint emp_eno_pk primary key;
    
-- 3. emp�� dno�� FK �߰�
    alter table emp
    modify dno constraint emp_dno_fk references dept;
    
-- �������� Ȯ��
    select table_name, constraint_name, constraint_type, status from user_constraints
    where table_name in ('EMP', 'DEPT');

-- ���������� ����
-- 2) cascade�� �����ϴ� ��� - �θ��� ���������� �����ϸ� �ڽ��� �������Ǳ��� �Ѳ����� ����
    alter table dept drop constraint dept_dno_pk cascade;
    
    alter table dept drop primary key cascade;






