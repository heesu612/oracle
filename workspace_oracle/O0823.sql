/*
< �ε����� ��� ���θ� �����ϴ� ���� >
 1. �ε����� ����ؾ� �ϴ� ���
  - ���̺��� ���� ���� ���� ��
  - where ���ǿ� �ش��ϴ� �÷��� ���� ���� ��
  - �˻� ��� ��ü �������� 2~4% ������ ��
  - join�� ���� ���Ǵ� �÷�, null���� �����ϴ� �÷��� ���� ��
  
 2. �ε����� ����ϸ� �ȵǴ� ���
  - ���̺��� ���� ���� ���� ��
  - where ���ǿ� �ش��ϴ� �÷��� ���� ������ ���� ��
  - �˻� ��� ��ü �������� 10~15% �̻��� ��
  - ���̺��� �߰�, ����, ������ ���� �߻��� ��
*/

-- �ε��� Ȯ��
    select * from user_indexes;
    select * from user_ind_columns;
    
    create table dept
    as select * from department;
-- �ε��� ����
    alter index idx_dept_dname rebuild;
    select * from user_indexes;
    select * from tab; -- ���� �������̺���� �� ���� ����.
    
/*
< �ý��� ���� >
 - ����� ������ ����, ���� �ο��� ȸ��, �ڿ� ���� ��� ���� �����ͺ��̽��� ������ �� �ִ� ����
 - �����ͺ��̽� ������(DBA, DataBase Administrator) ����
 
< �ý��� ���� >
 - create session : �����ͺ��̽� ���� ����
 - create table : ���̺� ���� ����
 - create sequence : �������� ������ �� �ִ� ����
 - create view: �並 ������ �� �ִ� ����
 - create user: ����� ������ �����ϴ� ����
 
< ���̺� �����̽� > table space
 - ���̺�, �� ���� ��ü�� ����Ǵ� ����
 
# ��ü : ���̺�, ��, ������, ���ν��� ...
< ��ü ���� >
 create - table, view, sequence, procedure
 alter - table, sequence
 drop - table, view, sequence, procedure
 
 insert - table, view
 update - table, view
 delete - table, view
 select - table, view, sequence
 
 index - table
 references - table
 execute - procedure
*/
-- ���̺� �����̽� Ȯ��
    select * from dba_users where username = 'USERTEST01';

-- ���̺� �����̽��� ������ ����ڿ��� �ο���
    alter user usertest01 default tablespace users quota unlimited on users;

-- �ý��ۿ��Լ� �ο����� ���� Ȯ��
    select * from session_privs;

-- ����ڰ� �ο��� ���� Ȯ��
    select * from user_tab_privs;

/*
< ��(role) ���� >
 - ������ ����
 - �پ��� ������ ȿ�������� ����ϰ�, ������ �� �ֵ��� ������ ���� ���� ��.
 
< �� ������ ���� >
 - ���� ���ǵ� �� : ����Ŭ���� �⺻������ �����ϴ� ��
 - ����� ���� �� : ����ڰ� ���� �����ؼ� ����ϴ� ��
 
 1. ���� ���ǵ� ��
  - connect : �����ͺ��̽��� ���ӿ� ���� ������ ����.
    ex) create session, create table, create view, create sequence, 
        create synonym, create cluster, create database link, alter session
  - resource : ��ü�� ������ �� �ֵ��� �ϴ� ������ ����.
    ex) create table, create view, create sequence, create cluster,
        create procedure, create trigger
  - dba : �ý��� ������ �ʿ��� ��� ������ ����.
    ex) with grant option�� �ִ� ��� ����
 2. ����� ���� ��
  - ����ڰ� ���� �� ������ ����� �����.
  - �ݵ�� DBA ������ �־�� ��.
  
*/

-- ����ڰ� �ο����� �� ���� Ȯ��, ����� ���� �� Ȯ��
    select * from user_role_privs;

-- ����� ���� �ѿ� �ο��� ���� Ȯ��
    select * from role_sys_privs;
    select * from role_sys_privs where role like 'ROLETEST%';
    commit;

-- ����� ���� �ѿ� �ο��� ���̺� ���� Ȯ��
    select * from role_tab_privs;
    select * from role_tab_privs where table_name in ('EMPLOYEE','DEPARTMENT');

/*
���� 416 �������� 3������ �ذ��Ͻÿ�.
*/

commit;

/*
< ���Ǿ� > synonym
 - �����ͺ��̽��� ���� ��Ī
 - ���̺�, ��, ������ � ���� ����ϱ� ���� �̸��� ���� ��.
 - ���� ���Ǿ�� DBA ������ ���� ����ڰ� ������ �� ����.
 
< ���Ǿ��� ���� >
 1. ���� ���Ǿ� 
  - ���� ����ڰ� �����Ͽ� ����ϴ� ���Ǿ�
  - ��ü�� ���� ���� ������ �ο����� ����ڰ� �����Ͽ� ����ϸ�, ������ ����ڸ� ��� ����.
 
 2. ���� ���Ǿ� 
  - ��ü ����ڰ� ����ϴ� ���Ǿ�
  - ������ �ο��ϴ� ����ڰ� �����ϴ� ���Ǿ�, ������ �� public�� �ٿ��� ������.
*/

-- ����ڰ� �ο��� ���̺� ���� Ȯ��
    select * from user_tab_privs;

-- ���� ���Ǿ Ȯ��
    select * from all_synonyms;
    select * from all_synonyms where synonym_name = 'P_DEPT';

-- ���� ���Ǿ� ����
    drop public synonym p_dept;
    
-- ���� ���Ǿ Ȯ�� --> ���� ���Ǿ ������ ����ڿ��� Ȯ��
    select * from user_synonyms;
    
-- ���� ���Ǿ ���� --> ���� ���Ǿ ������ ����ڿ��� ����
    drop synonym s_emp;
    
-- ���� 357 �������� 3���� �ذ�  
    



























































































































































































































