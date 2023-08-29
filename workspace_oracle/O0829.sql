-- < Trigger ���� Ȯ�� �н� >    
-- 19�� ���� 520~521 �������� 3�� Ʈ���� ������ �ذ�

-- sys_context('USERENV', 'SESSION_USER') : ����Ŭ���� �ý��ۿ� ������ ����� �̸��� Ȯ��

-- �μ� ���̺� ����  : Ʈ���� �̺�Ʈ �߻� ���̺�
    create table dept_trg
    as select * from department;

-- �α� ��� ���̺� ���� : Ʈ���� ��� ����
    create table dept_trg_log (
    tablename varchar2(10),
    dml_type varchar2(10),
    deptno number(2),
    user_name varchar2(30),
    change_date date
    );

    set serveroutput on;
    
-- Ʈ���� ����
    create or replace trigger trg_dept_log
        after insert or update or delete
        on dept_trg
        for each row
    begin
        if inserting then
            dbms_output.put_line('DEPT_TRG ���̺� �����Ͱ� �߰��Ǿ����ϴ�.');
            insert into dept_trg_log values('dept_trg','insert', :new.dno, sys_context('USERENV', 'SESSION_USER'), sysdate);
        elsif updating then
            dbms_output.put_line('DEPT_TRG ���̺��� �����Ͱ� �����Ǿ����ϴ�.');
            insert into dept_trg_log values('dept_trg','update', :old.dno, sys_context('USERENV', 'SESSION_USER'), sysdate);
        elsif deleting then
            dbms_output.put_line('DEPT_TRG ���̺��� �����Ͱ� �����Ǿ����ϴ�.');
            insert into dept_trg_log values('dept_trg','delete', :old.dno, sys_context('USERENV', 'SESSION_USER'), sysdate);
        end if;
    end;
    /

-- Ʈ���� Ȯ��
    select * from user_triggers;
    select * from user_source where name = 'TRG_DEPT_LOG';
    

-- Ʈ���� ���� Ȯ��
-- 1�� : ������ �߰�
    insert into dept_trg values(99, 'MARKETING', 'SEOUL');
    select * from dept_trg;
    select * from dept_trg_log;
    select tablename ���̺��, dml_type DMLŸ��, deptno �μ���ȣ, user_name �����, to_char(change_date, 'YYYY/MM/DD AM HH:MI:SS') ��¥ from dept_trg_log;
    commit;
    
-- 2�� : ������ ����
    update dept_trg set loc = 'BUSAN' where dno = 99;
    select * from dept_trg;
    select tablename ���̺��, dml_type DMLŸ��, deptno �μ���ȣ, user_name �����, to_char(change_date, 'YYYY/MM/DD AM HH:MI:SS') ��¥ from dept_trg_log;
    
-- 3�� : ������ ����
    delete dept_trg where dno = 99;
    select * from dept_trg;
    select tablename ���̺��, dml_type DMLŸ��, deptno �μ���ȣ, user_name �����, to_char(change_date, 'YYYY/MM/DD AM HH:MI:SS') ��¥ from dept_trg_log;    
    select * from dept_trg_log;
    commit;
    






























































































































































