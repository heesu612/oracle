/*
< �Լ��� ���� >
 1. ���� �Լ� : ����Ŭ�� ����� ���� �Լ�
 2. ����� ���� �Լ� : ����ڰ� �����ϴ� �Լ�
 
< �Լ� (Function) >
 - �ݵ�� �� ���� ���� �����Ͽ� SQL������ ����� �� �ֵ��� �ϴ� PL/SQL 
 
< ���ν����� �Լ��� ������ >
 1. ���ν���
  - execute ���, �ٸ� PL/SQL ���ο��� ȣ���Ͽ� ����
  - �Ű����� : (in, out, in out ���) ���� ���� ����� �� �ְ�, �������� ���� ���� ����
  - ���ϰ� :  (out, in out ���)�� ���� ���� ����� �� �ְ�, ���� ���� ����.
  
 2. �Լ�
  - execute ���, �ٸ� PL/SQL ���ο��� ȣ���Ͽ� ����, SQL�� ���ο��� ���� ��� ����
  - �Ű����� : (in ��常 ����) ���� ���� ����� �� �ְ�, �������� ���� ���� ����
  - ���ϰ� : �ݵ�� 1���� ����, ���� ���� ����. return���� ���
*/

-- �Լ��� ����
-- ���� 1��) ������� �Է��Ͽ�, ������ �����ϴ� �Լ��� �����ϰ�, ���
    create or replace function fn_emp01 ( v_ename in employee.ename%type)
        return number
    is
        v_salary employee.salary%type;
    begin
        select salary into v_salary
        from employee
        where ename = v_ename;
        return v_salary;
    end;
    /

-- �Լ� Ȯ��
    select * from all_objects where object_name like 'FN%';
-- �Լ� ���� Ȯ��    
    select * from user_source where name = 'FN_EMP01';

-- �Լ� ����
    drop function fn_emp01;

-- �Լ� ��� 1��
    var v_salary nuber;
    execute : v_salary := fn_emp01('SCOTT');
    print v_salary;

-- �Լ� ��� 2�� : PL/SQL���� ���
    
    set serveroutput on;
    declare
        v_ename employee.ename%type;
        v_salary employee.salary%type;
    begin
        v_ename := '&input_ename';
        v_salary := fn_emp01(v_ename);
        
        dbms_output.put_line(v_ename || ' ����� ���� : ' || v_salary);
    end;
    /

-- �Լ� ��� 3�� : SQL���� ���
    select ename, fn_emp01('SCOTT')
    from employee
    where ename = 'SCOTT';

-- ����2��) ��� ���̺� �־��� ����� �ѿ����� ���� ������ ����ϴ� �Լ��� �����ϰ�, ���
-- ������ ������ �������� ���� �ѿ����� ���ؼ� 10%�� ���
-- �Լ��� : fn_emp_tax

    create or replace function fn_emp_tax(v_ename employee.ename%type)
        return number    
    is
        v_tax number(7,2);
    begin
        select (salary+nvl(commission,0))*0.1 into v_tax
        from employee
        where ename = v_ename;
        return v_tax;
    end;
    /

-- �Լ� Ȯ��
    select * from all_objects where object_name like 'FN%';
    select * from user_source where name = 'FN_EMP_TAX';
-- �Լ� ��� 1��
    var v_tax number;
    execute :v_tax := fn_emp_tax('KING');
    print v_tax;
    
-- �Լ� ��� 2��
    declare
        v_ename employee.ename%type;
        v_tax number(7,2);
    begin
        v_ename := '&input_ename';
        v_tax := fn_emp_tax(v_ename);
        dbms_output.put_line(v_ename || ' ����� ���� : ' || v_tax);
    end;
    /

-- �Լ� ��� 3��
    select eno ���, ename �����, salary ����, nvl(commission,0) ������, fn_emp_tax('KING') ����
    from employee
    where ename = 'KING';

-- ���� 3��) ��� ���̺��� ��� ����� ������ ���
-- ��� ����� ������ ����ϴ� �Լ��� ����� ���
-- ����� ������ ������ �������� ���� �ݾ׿� 10%�� ����
-- ����� ���, �����, ����, ������, ����, �ǿ���(���ݰ���)�� �ǿ����� ������������ ���
-- �Լ��� : fn_emp_tax_all

-- �Լ� ����
    create or replace function fn_emp_tax_all(v_salary number, v_commission number)
        return number
    is 
        v_tax number(7,2);
    begin
        v_tax := (v_salary + nvl(v_commission,0)) * 0.1;
        return v_tax;
    end;
    /

-- �Լ� Ȯ��
    select * from all_objects where object_name like 'FN%';
    select * from user_source where name = 'FN_EMP_TAX_ALL';

-- �Լ� ��� 1��
    var v_tax number;
    execute : v_tax := fn_emp_tax_all(2000,500);
    print v_tax;

-- �Լ� ��� 2��
    declare
        v_emp employee%rowtype;
        v_tot number(7,2);
        v_tax number(7,2);
        cursor c1 is select * from employee order by salary+nvl(commission,0) desc;
    begin
        dbms_output.put_line(' ��� | ����� | ���� | ������ | �ѿ��� | ���� | �ǿ���(���ݰ���)');
        dbms_output.put_line('---------------------------------------------------------');
        for v_emp in  c1 loop
            exit when c1%notfound;
            v_tax := fn_emp_tax_all(v_emp.salary, v_emp.commission);
            v_tot := v_emp.salary+nvl(v_emp.commission,0);
            dbms_output.put_line(v_emp.eno || ' | ' || v_emp.ename || ' | ' || 
                v_emp.salary || ' | ' || nvl(v_emp.commission,0)|| ' | ' || 
                v_tot || ' | ' || v_tax || ' | ' || (v_tot-v_tax));
        end loop;
    end;
    /

-- �Լ� ��� 3��
    select eno ���, ename �����, salary ����, nvl(commission,0) ������, salary+nvl(commission,0) �ѿ���,
    fn_emp_tax_all(salary, commission) ����, salary+nvl(commission,0)-fn_emp_tax_all(salary, commission) �ǿ���
    from employee
    order by �ǿ��� desc;


-- < ���� Ȯ�� �н� >
-- ���� 19�� 518~519 �������� 2����
-- 1��) ���ν���
    create or replace procedure pro_dept_in(
        v_dno in out department.dno%type, v_dname out department.dname%type, v_loc out department.loc%type) 
    is
    begin
        select dno, dname, loc into v_dno, v_dname, v_loc
        from department
        where dno = v_dno;
    end;
    /
    
-- Ȯ��
    select * from user_procedures;
    select * from user_source where name = 'PRO_DEPT_IN';
    
    declare
        v_dno department.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    begin
        v_dno := &input_dno;
        pro_dept_in(v_dno, v_dname, v_loc);
        dbms_output.put_line(' �μ���ȣ | �μ��� | ������ ');
        dbms_output.put_line('---------------------------');
        dbms_output.put_line(v_dno || ' | ' || v_dname || ' | ' || v_loc);
    end;
    /
    
    
-- 2��) �Լ�
    create or replace function fn_date_kor(v_hiredate date)
        return varchar2
    is
    begin
        return to_char(v_hiredate, 'YYYY"��" MM"��" DD"��"');
    end;
    /

-- Ȯ��
    select * from all_objects where object_name like 'FN%';
    select * from user_source where name = 'FN_DATE_KOR';
    
-- ���
    select eno ���, ename �����, fn_date_kor(hiredate) �Ի���
    from employee
    order by hiredate;

/*
< ��Ű�� (Package) >
 - ���� �ִ� ���ν���, �Լ��� �ϳ��� ������ �׷����� ��� ����ϴ� ��ü
 - ������ ��ɸ鿡�� ����ϰ�, �����ϱ⿡ ������.
 
< ��Ű���� ���� >
 1. ���ȭ : ���� ���� ����, ���ν���, �Լ��� �ϳ��� ��� ���
 2. ������ ���� : ���α׷��� ���谡 ��������.
 3. ���� ���� : ��Ű�� �ȿ� ���ν���, �Լ��� ���������ν� ������ ��ȭ��
 4. ��ɼ� ��� : ���ȭ�Ͽ� ��������ν� ����� ����� �� ����.
 5. ���� ��� : ��Ű�� �ȿ� �ִ� ���ν���, �Լ��� �Ѳ����� �����Ͽ� ��������� ���� ����� �� ����.

< ��Ű���� ���� ��� >
 1. ��Ű�� ���� : �Լ� �Ǵ� ���ν����� ����
 2. ��Ű�� ����(�ٵ�) ���� : �Լ� �Ǵ� ���ν����� ������ ����
*/

-- 1. ��Ű���� ����� ���� - ����, ���ν���, �Լ�
    create or replace package pkg_ex01
    is
        v_number number := 10; -- ���� ����
        function fn_after_tax(v_salary number) return number; -- �Լ� ����
        procedure sp_emp(v_eno in employee.eno%type);
        procedure sp_dept(v_dno in department.dno%type);

    end;
    /
    
-- 2. ��Ű���� ���� ����
    create or replace package body pkg_ex01
    is
    -- �Լ�
        function fn_after_tax(v_salary number) return number
        is
            v_tax number := 0.1;
        begin
            return v_salary - (v_salary*v_tax);
        end;
    -- ���ν���
        procedure sp_emp(v_eno employee.eno%type)
        is
            v_ename employee.ename%type;
            v_salary employee.salary%type;
        begin
            select ename, salary into v_ename, v_salary 
            from employee
            where eno = v_eno;
            
            dbms_output.put_line(v_ename || '����� ���� : ' || v_salary);
        end;
    -- ���ν���
        procedure sp_dept(v_dno department.dno%type)
        is
            v_dname department.dname%type;
            v_loc department.loc%type;
        begin
            select dname, loc into v_dname, v_loc
            from department
            where dno = v_dno;
            
            dbms_output.put_line(v_dname || ' : ' || v_loc);
        end;
    end;
    /

-- ��Ű�� Ȯ��
    select * from all_objects where object_name like 'PKG%';
-- ��Ű�� ���� Ȯ��
    select * from user_source where name = 'PKG_EX01';
-- ��Ű�� ���� Ȯ��
    desc pkg_ex01;

-- ��Ű�� ���
    set serveroutput on;
    begin
        dbms_output.put_line('���� ���� �� ���� : ' || pkg_ex01.fn_after_tax(3000));
        dbms_output.put_line(' 7788 ����� ���� ');
        pkg_ex01.sp_emp(7788);
        dbms_output.put_line(' 10�� �μ��� ���� ');
        pkg_ex01.sp_dept(10);
    end;
    /

-- ��Ű�� ����
    drop package pkg_ex01; -- �������� �Բ� ����
    drop package body pkg_ex01; -- ������ ����

-- ��Ű���� ���ν��� �����ε�(overloading)
-- ��Ű�� ���� ����
    create or replace package pkg_ex02 
    is
        procedure sp_emp(v_eno employee.eno%type); -- ������� ���� ��ȸ
        procedure sp_emp(v_ename employee.ename%type); -- ��������� ���� ��ȸ
    end;
    /

    create or replace package body pkg_ex02
    is
        -- ���ν��� 1
        procedure sp_emp(v_eno employee.eno%type)
        is
            v_ename employee.ename%type;
            v_salary employee.salary%type;
        begin   
            select ename, salary into v_ename, v_salary 
            from employee
            where eno = v_eno;
            
            dbms_output.put_line(v_eno || ' | ' || v_ename || ' | ' || v_salary);
        end;
        
        -- ���ν��� 2
        procedure sp_emp(v_ename employee.ename%type)
        is
            v_eno employee.eno%type;
            v_salary employee.salary%type;
        begin
            select eno, salary into v_eno, v_salary
            from employee
            where ename = v_ename;
            
            dbms_output.put_line(v_eno || ' | ' || v_ename || ' | ' || v_salary);
        end;
        
    end;
    /

-- ��Ű�� Ȯ��
    select * from all_objects where object_name like 'PKG%';
    select * from user_source where name = 'PKG_EX02';
    desc pkg_ex02;
    
-- ��Ű�� ���
    begin 
        pkg_ex02.sp_emp(7369);
        pkg_ex02.sp_emp('SCOTT');
    
    end;
    /


-- < ��Ű������ �Լ��� �����ε�(overloading) >
-- ��Ű�� ���� ����
    create or replace package pkg_ex03 
    is
        function fn_emp(v_eno employee.eno%type) return number; -- ������� ���� ��ȸ
        function fn_emp(v_ename employee.ename%type) return number; -- ��������� ���� ��ȸ
    end;
    /

-- ��Ű�� �ٵ� ����
    create or replace package body pkg_ex03
    is
        -- �Լ� 1
        function fn_emp(v_eno employee.eno%type) return number
        is
            v_salary employee.salary%type;
        begin   
            select salary into v_salary 
            from employee
            where eno = v_eno;
            
            return v_salary;
        end;
        
        -- �Լ� 2
        function fn_emp(v_ename employee.ename%type) return number
        is
            v_salary employee.salary%type;
        begin
            select salary into v_salary
            from employee
            where ename = v_ename;
            
            return v_salary;
        end;
        
    end;
    /

-- ��Ű�� Ȯ��
    select * from all_objects where object_name like 'PKG%';
    select * from user_source where name = 'PKG_EX03';
    desc pkg_ex03;

-- ��Ű�� ��� (�Լ� �����ε�)
    select eno, ename, pkg_ex03.fn_emp(7369)
    from employee
    where eno = 7369;

    select eno, ename, pkg_ex03.fn_emp('KING')
    from employee
    where ename = 'KING';   


/*
< Ʈ���� (Trigger) >
 - �����ͺ��̽� �ȿ��� Ư���� ��Ȳ�̳� ���� �� �̺�Ʈ�� �߻��� ��� �ڵ����� ����Ǵ� ����� ������ PL/SQL��
 - ��Ƽ�, �������� ����, ���Ӽ��� ������ ������ �ù���.
 EX) �����ͺ��̽��� ������ �α� ����� ���� ��, �����ͺ��̽��� ��ü ���� �ϰ����� �����ϰ��� �� ��...
 
< Ʈ������ ���� >
 1. Ư�� �����Ϳ� ���õ� ���� �۾��� ������ �� ���� ���α׷��� �Ѳ����� ������ �� ����.
 2. �������� ���� ������ ����� �۾��鿡 ���� ������ ��Ģ�� �����Ͽ� ���� ����� ������.
 3. ������ ����� ���õ� �Ϸ��� ������ ����� �������ν� ���� ����ڰ� �����ϴ� �����Ϳ� ���Ȱ� �������� ����ų �� ����.

< Ʈ������ ���� >
 1. ���к��� Ʈ������ ������ ����� �����ͺ��̽��� ������ ����߸��� ��.

< Ʈ������ ���� 1 >
 - �̺�Ʈ�� �߻��ϴ� ������ ���� 
  1. after Ʈ����
   - �̺�Ʈ�� �߻��� �Ŀ� Ʈ���Ű� �����ϴ� ��
  2. before Ʈ����
   - �̺�Ʈ�� �߻��ϱ� ���� Ʈ���Ű� �����ϴ� �� 
   
< Ʈ������ ���� 2 >
 - Ʈ���Ű� �� �ึ�� �߻��ϴ� ���� ���ο� ����
  1. �� ���� Ʈ����
   - ���� ���� ���� ����� ��, �� �ึ�� �߻��ϴ� Ʈ����.
  2. ���� ���� Ʈ����
   - �̺�Ʈ�� ���� �� �ѹ��� �߻��ϴ� Ʈ����.

# �� ���� Ʈ���ſ��� ���� �÷��� �����ϴ� ������ 2����
 - :old -> ���� ���� ��
 - :new -> ���� ���� ��
   
< Ʈ������ ���� 3 >
 - �߻��ϴ� �̺�Ʈ�� ������ ����
  1. DML Ʈ����
   - ���̺��� ����ϴ� DML ��ɿ� ���� �߻��ϴ� Ʈ����
   - �Ϲ������� ���� ���� ����ϴ� Ʈ����
  2. DDL Ʈ����
   - ���̺��� ����ϴ� DDL ��ɿ� ���� �߻��ϴ� Ʈ����
  3. instead of Ʈ����
   - �信 ����ϴ� DML Ʈ����
  4. �ý��� Ʈ����
   - �����ͺ��̽��� ��Ű������ �����ϴ� Ʈ����
 
< Ʈ������ ���� 4 > 
 - Ʈ���Ű� �� ���� �Ǵ� ���� �������� �����ϴ� ���� ���ο� ����
  1. �ܼ� Ʈ����
   - Ʈ���Ű� �� �������� ������.
  2. ���� Ʈ����
   - Ʈ���Ű� ���� �������� ������.
   
*/

-- Insert Ʈ����
-- ���� 1��) �μ� ���̺� ���ο� �����Ͱ� �߰��� ��, ��� ���̺��� �����͸� �����ϴ� Ʈ���Ÿ� �����ϰ� Ȯ��
-- ���� ���̺�
    create table dept_origin
    as select * from department;

-- ��� ���̺�
    create table dept_backup
    as select * from department where 0 = 1;
    
-- Ʈ���� ����
    create or replace trigger t_dept1
        after insert -- after Ʈ���� 
        on dept_origin
        for each row -- �� ���� Ʈ���� (�����ϸ� ���� ���� Ʈ����)
    begin
        if inserting then
            dbms_output.put_line('Insert Trigger �߻��Ͽ����ϴ�.');
            insert into dept_backup values(:new.dno, :new.dname, :new.loc);
        end if;
    end;
    /

-- Ʈ���� Ȯ��
    select * from user_triggers;

-- Ʈ���� ����
    drop trigger t_dept1;
    
-- Ʈ���� ���� Ȯ��
    insert into dept_origin values(50, 'MARKETING', 'SEOUL');
    commit;
    
    select * from dept_origin;
    select * from dept_backup;

-- < Delete Trigger >
-- ����2��) �μ� ���̺��� ������ �����Ͽ��� ��, ��� ���̺��� �����ϴ� Ʈ���Ÿ� �����ϰ� Ȯ��.
    create or replace trigger t_dept2
        after delete
        on dept_origin
        for each row
    begin
        if deleting then 
            dbms_output.put_line('Delete Trigger �߻�');
            delete dept_backup where dno = :old.dno;
        end if;
    end;
    /

-- Ʈ���� Ȯ��
    select * from user_triggers;
    select * from user_source where name = 'T_DEPT2';

-- Ʈ���� ���� Ȯ��
    delete dept_origin where dno = 50;
    commit;
    
    select * from dept_origin;
    select * from dept_backup;

-- ����3��) �μ� ���̺��� �����Ͱ� �����Ǿ��� ��, ������ �����͸� ��� ���̺� �߰��ϴ� Ʈ���Ÿ� �����ϰ�, Ȯ��
    create or replace trigger t_dept3 -- ���� ���� ������ 2�� �ٲٷ��µ� �ȹٲ� ��
        after delete
        on dept_origin
        for each row
    begin
        if deleting then
            dbms_output.put_line('Delete Trigger�� �߻��Ͽ����ϴ�.');
            dbms_output.put_line('������ �����Ͱ� ����Ǿ����ϴ�.');
            insert into dept_backup values(:old.dno, :old.dname, :old.loc);
        end if;
    end;
    /

-- Ʈ���� Ȯ��
    select * from user_triggers;
    select * from user_source where name = 'T_DEPT3'; -- ���� ���� ������ 2�� �ٲٷ��µ� �ȹٲ� ��
    
-- Ʈ������ ���� Ȯ��
    delete dept_origin where dno in (30, 40);

    rollback;

    select * from dept_origin;
    select * from dept_backup;

-- < Update Trigger >
-- ����4��) �μ� ���̺��� ������ �����Ͽ��� ��, ��� ���̺��� ���뵵 ����Ǵ� Ʈ���Ÿ� �����ϰ�, Ȯ��
-- �μ���ȣ�� ���ؼ� �μ��� �Ǵ� �������� ������ �� 
    truncate table dept_origin;
    truncate table dept_backup;
    
    insert into dept_origin select * from department;
    commit;

-- Ʈ���� ����
    create or replace trigger t_dept4
        after update
        on dept_origin
        for each row
    begin
        if updating then
            dbms_output.put_line('Update Trigger�� �߻�.');
            update dept_backup 
            set dname = :new.dno, loc = :new.dno 
            where dno = :new.dno;
        end if;
    end;
    /

-- Ʈ���� Ȯ��
    select * from user_triggers;
    select * from user_source where name = 'T_DEPT4';
    
-- Ʈ���� ���� Ȯ��
    update dept_origin
    set dname = 'INFO'
    where dno = 10;
    
    select * from dept_origin;
    select * from dept_backup;
    
    update dept_origin
    set loc = 'SEOUL'
    where dno = 20;
    
    update dept_origin
    set dname = 'MARKETING', loc = 'BUSAN'
    where dno = 30;
    
    commit;
    
-- ����5��) �μ����̺��� ������ ����Ǿ��� ��, ����Ǳ� ���� ������ ��� ���̺� ����
-- �μ���ȣ�� ���ؼ� �μ����, �������� �������� ��
    create or replace trigger t_dept4
        before update
        on dept_origin
        for each row
    begin 
        if updating then
            dbms_output.put_line('Update Trigger�� �߻�');
            insert into dept_backup values(:old.dno, :old.dname, :old.loc);
        end if;
    end;
    /
    
-- Ʈ���� Ȯ��
    select * from user_triggers;
    select * from user_source where name = 'T_DEPT4';
    
-- Ʈ���� ���� Ȯ��
    update dept_origin
    set dname = 'PART1'
    where dno = 10;

    update dept_origin
    set loc = 'INCHEON'
    where dno = 20;
    
    update dept_origin
    set dname = 'PART2', loc = 'DAEGU'
    where dno = 30;

    select * from dept_origin;
    select * from dept_backup;

-- < Trigger ���� Ȯ�� �н� >    
-- 19�� ���� 520~521 �������� 3�� Ʈ���� ������ �ذ�


