
-- ����18) employee ����� ���� �����ϴ� ���ڵ带 �����Ͽ�, ���ڵ��� ���� employee ���̺�
-- �����ϴ� PL/SQL�� �����Ͻÿ�.
-- ���ڵ��: RECORD_EMP

    set serveroutput on;
    
    declare
        -- ���ڵ� ����
        type RECORD_EMP is record (
            eno employee.eno%type,
            ename employee.ename%type,
            job employee.job%type,
            manager employee.manager%type,
            hiredate employee.hiredate%type,
            salary employee.salary%type,
            commission employee.commission%type,
            dno employee.dno%type
        );
        -- ���ڵ� ���� ����
        emp_r RECORD_EMP;
        
    begin
        emp_r.eno := 8100;
        emp_r.ename := 'LEE';
        emp_r.job := 'SALESMAN';
        emp_r.manager := 7839;
        emp_r.hiredate := sysdate;
        emp_r.salary := 4000;
        emp_r.commission := 1000;
        emp_r.dno := 30;
        
        insert into employee values emp_r;
    end;
    /
    commit;
    
/*
< Ŀ���� Ȱ���� for loop�� >
# Ŀ�� (sursor)
 - select ���� ����� ���� ���� ��ȸ�Ǿ��� �� �� ���� ���� ����� ȭ������ ����� �� �ֵ��� �ϴ� ���
 
< Ŀ���� ����ϴ� ��� >
 1. �⺻ loop������ ����ϴ� ���
  - 1�ܰ� : Ŀ�� ����(declare)
  - 2�ܰ� : Ŀ�� ����(open)
  - 3�ܰ� : Ŀ�� ���(fetch)
  - 4�ܰ� : Ŀ�� �ݱ�(close)
  
 2. for loop������ ����ϴ� ���
  - 1�ܰ� : Ŀ�� ����(declare)
  - 2�ܰ� : Ŀ�� ���(�ڵ����� open, fetch, close)

< for loop���� ������ ���� >
 # ����
 1. Ŀ���� open, fetch, close�� ������
 2. exit���� ������
 3. ���۷��� ������ ���� ������
 
 # ����
 1. Ŀ���� �پ��� �Ӽ��� ����� �� ����
 

< Ŀ���� ���� >
 1. ����� Ŀ��
  - Ŀ���� ��������� �����ϰ� ����ϴ� ���
 
 2. �Ϲ���(������) Ŀ��
  - Ŀ���� �������� �ʰ�, �Ϲ������� ����ϴ� ���
  - SQLŰ����� Ŀ���� �Ӽ��� ����Ͽ�, �ڵ����� �����Ǵ� Ŀ��
  - sql%notfound, sql%found, sql%rowcount, sql%isopen
  
< Ŀ���� �Ӽ� >
 1. Ŀ����%notfound : ���� ã�� ���ߴٸ� true, ã�Ҵٸ� false
 2. Ŀ����%found : ���� ã�Ҵٸ� true, ã�� ���ߴٸ� false
 3. Ŀ����%rowcount : ������ ���� ���� ����
 4. Ŀ����%isopen : Ŀ���� ���������� true, �������� false
*/
-- ����1) �μ� ���̺��� ��� ����� ����Ͻÿ�.
 -- 1�� ��� : �⺻ loop��
    declare
        v_dept department%rowtype;
        -- 1. Ŀ�� ����
        cursor c1 is select * from department;
    begin
        dbms_output.put_line('�μ���ȣ | �μ��� | ������');
        dbms_output.put_line('------------------------');
        -- 2. Ŀ�� ����
        open c1;  
        loop
            -- 3. Ŀ�� ���(fetch)
            fetch c1 into v_dept.dno, v_dept.dname, v_dept.loc;
            exit when c1%notfound;
            dbms_output.put_line(v_dept.dno || ' | ' || v_dept.dname || ' | ' || v_dept.loc);
        end loop;
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('�μ� ���� : ' || c1%rowcount);
        -- 4. Ŀ�� �ݱ�
        close c1;
    end;
    /
 -- 2�� ��� : for loop��
    declare
        v_dept department%rowtype; -- ��������
        -- 1. Ŀ�� ����
        cursor c1 is select * from department;
    begin
        dbms_output.put_line('�μ���ȣ | �μ��� | ������');
        dbms_output.put_line('------------------------');
        -- 2. Ŀ�� ���
        for v_dept in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v_dept.dno || ' | ' || v_dept.dname || ' | ' || v_dept.loc);
        end loop;

    end;
    /  
    
-- ����2��) ��� ���̺��� ������ 2000���� 3000 ������ ����� ������ ������ ���� ������, ��������� ���
-- �⺻ loop��, for loop�� 2���� ������� �ذ�
 -- 1�� : �⺻ loop��
 
    declare
        v_emp employee%rowtype;
        cursor c1 is 
        select * from employee 
        where salary between 2000 and 3000 
        order by salary desc, eno;
    begin
        dbms_output.put_line('��� | ����� | ���� | �����ڹ�ȣ | �Ի��� | ���� | ������ | �μ���ȣ');
        dbms_output.put_line('-----------------------------------------------------');
        open c1;
        loop
            fetch c1 into v_emp;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job || ' | ' || v_emp.manager || ' | ' || 
            v_emp.hiredate || ' | ' || v_emp.salary || ' | ' || nvl(v_emp.commission,0) || ' | ' || v_emp.dno);
        end loop;
        close c1;
    end;
    /
    
 -- 2�� : for loop��
    declare
        v_emp employee%rowtype;
        cursor c1 is 
        select * from employee 
        where salary between 2000 and 3000 
        order by salary desc, eno;
    begin
        dbms_output.put_line('��� | ����� | ���� | �����ڹ�ȣ | �Ի��� | ���� | ������ | �μ���ȣ');
        dbms_output.put_line('-----------------------------------------------------');
        for v_emp in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job || ' | ' || v_emp.manager || ' | ' || 
            v_emp.hiredate || ' | ' || v_emp.salary || ' | ' || nvl(v_emp.commission,0) || ' | ' || v_emp.dno);
        end loop;
    end;
    /
    
-- ����3��) ��� ���̺��� �������� �޴� ����� ���, �����, ����, ������, �μ���ȣ, �μ����� ���
-- �������� ���� ������, ������ ���� ������ ���
-- �⺻ loop��, for loop��
 -- 1�� : �⺻ loop��
-- 1��: �⺻ loop��
    declare
        type RECORD_ED is record (
            eno employee.eno%type,
            ename employee.ename%type,
            salary employee.salary%type,
            commission employee.commission%type,
            dno employee.dno%type,
            dname department.dname%type
        );
        ed_r RECORD_ED;
        -- Ŀ�� ����
        cursor c1 is 
        /*
        select eno, ename, salary, commission, e.dno, dname 
        from employee e join department d
        on e.dno = d.dno where commission is not null 
        */
        select eno, ename, salary, commission, dno, dname
        from employee natural join department
        where commission is not null
        
        order by commission desc, salary desc;
    begin
    dbms_output.put_line('��� | ����� | ���� | ������ | �μ���ȣ | �μ���');
        dbms_output.put_line('-------------------------------------------');
        open c1;
        loop
            fetch c1 into ed_r;
            exit when c1%notfound;
            dbms_output.put_line(ed_r.eno || ' | ' || ed_r.ename || ' | ' || ed_r.salary || ' | ' || 
            ed_r.commission || ' | ' || ed_r.dno || ' | ' || ed_r.dname);
            
        end loop;
        close c1;
    end;
    /
    

 -- 2�� : for loop��
    declare
        cursor c1 is
        select eno, ename, salary, commission, dno, dname
        from employee natural join department
        where commission is not null
        order by commission desc, salary desc;
    begin
        dbms_output.put_line('��� | ����� | ���� | ������ | �μ���ȣ | �μ���');
        dbms_output.put_line('-----------------------------------------------------');
        for v_ed in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v_ed.eno || ' | ' || v_ed.ename || ' | ' ||  v_ed.salary || ' | ' ||  
            v_ed.commission || ' | ' || v_ed.dno || ' | ' || v_ed.dname);
        end loop;
    end;
    /
    
-- ���� 4��) ��տ������� ���� ������ �ް�, �̸��� 'K'�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� 
-- ����� ���, �����, ����, �μ���ȣ, �μ����� ���
-- ������ ������, �μ���ȣ ������ ���
-- 1�� : �⺻ loop��
    declare
    type RECORD_ED is record(
            eno employee.eno%type,
            ename employee.ename%type,
            salary employee.salary%type,
            dno employee.eno%type,
            dname department.dname%type
        );
        ed_r RECORD_ED;
        cursor c1 is
        select eno, ename, salary, dno, dname
        from employee natural join department
        where salary > (select avg(salary) from employee)
        and dno in (select dno from employee where ename like '%K%')
        order by salary desc, dno;
    begin
        dbms_output.put_line('��� | ����� | ���� | �μ���ȣ | �μ���');
        dbms_output.put_line('-----------------------------------------------------');
        open c1;
        loop
            fetch c1 into ed_r;
            exit when c1%notfound;
            dbms_output.put_line(ed_r.eno || ' | ' || ed_r.ename || ' | ' ||  ed_r.salary || ' | ' ||  
            ed_r.dno || ' | ' || ed_r.dname);
        end loop;
        close c1;
    end;
    /

-- 2�� : for loop��
    declare
        cursor c1 is
        select eno, ename, salary, dno, dname
        from employee natural join department
        where salary > (select avg(salary) from employee)
        and dno in (select dno from employee where ename like '%K%')
        order by salary desc, dno;
    begin
        dbms_output.put_line('��� | ����� | ���� | �μ���ȣ | �μ���');
        dbms_output.put_line('-----------------------------------------------------');
        for v_ed in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v_ed.eno || ' | ' || v_ed.ename || ' | ' ||  v_ed.salary || ' | ' ||  
            v_ed.dno || ' | ' || v_ed.dname);
        end loop;
    end;
    /

-- ����5��) �����ڰ� ���� ����� ������ ���������� 2000�̸��� �׷��� �����ϰ�, ������ ���������� ���
-- �����޿��� ���� ������ ���
-- 1�� : �⺻ loop��
    declare
        v_job varchar2(9);
        v_min_salary number(7,2);
        cursor c1 is
        select job, min(salary) 
        from employee
        where manager is not null
        group by job
        having not min(salary) < 2000
        order by min(salary) desc;
    begin
        open c1;
        loop
            fetch c1 into v_job, v_min_salary;
            exit when c1%notfound;
            dbms_output.put_line(v_job || ' | ' || v_min_salary);
        end loop;
        close c1;
    end;
    /

-- 2�� : for loop��
    declare
        cursor c1 is
        select job, min(salary) min_salary
        from employee
        where manager is not null
        group by job
        having not min(salary) < 2000
        order by min(salary) desc;
    begin
        for v in c1 loop
            exit when c1%notfound;
            dbms_output.put_line(v.job || ' | ' || v.min_salary);
        end loop;
    end;
    /
    
-- �Ϲ��� Ŀ�� Ȱ�� ����
    insert into employee(eno, ename, job, dno) values(9000, 'KIM', 'STUDENT',40);
    insert into employee(eno, ename, job, dno) values(9100, 'LEE', 'STUDENT',40);
    insert into employee(eno, ename, job, dno) values(9200, 'PARK', 'STUDENT',40);
    insert into employee(eno, ename, job, dno) values(9300, 'CHOI', 'STUDENT',40);
    insert into employee(eno, ename, job, dno) values(9400, 'JONG', 'STUDENT',40);
    COMMIT;
-- ���� 6��)
    begin
        update employee set job= 'SALESMAN' where eno>= 9000;
        
        dbms_output.put_line('���ŵ� ��� : ' || sql%rowcount);
        
        if sql%found then
            dbms_output.put_line('���ŵ� ���� �ֽ��ϴ�.');
        else
            dbms_output.put_line('���ŵ� ���� �����ϴ�.');
        end if;
        
        if sql%isopen then
            dbms_output.put_line('Ŀ���� open �Ǿ����ϴ�.');
        else
            dbms_output.put_line('Ŀ���� open �����ʾҽ��ϴ�.');
        end if;
        
    end;
    /
    
-- Ŀ���� Ȱ�� 1�� : ���ǿ� ���� �ٸ� ����� ������ �� ����.
    declare
        v_emp employee%rowtype;
        cursor c1(e_dno employee.dno%type) is
        select * from employee where dno = e_dno;
        
    begin
        -- 10�� �μ�
        open c1(10);
        loop
            fetch c1 into v_emp;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.dno || ' | ' || v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job);
        end loop;
        close c1;
        
        dbms_output.put_line('---------------------------------------');
        -- 20�� �μ�
        open c1(20);
        loop
            fetch c1 into v_emp;
            exit when c1%notfound;
            dbms_output.put_line(v_emp.dno || ' | ' || v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job);
        end loop;
        close c1;
    end;
    /
    

-- Ŀ���� Ȱ�� 2�� : �Է�â�� �����Ͽ� 
    declare
        v_emp employee%rowtype;
        cursor c1(e_eno employee.eno%type) is 
        select * from employee where eno = e_eno;
    begin
        -- �Է�â�� ���� ������ ���� �Է���. -- ����
        v_eno := &input_dno;
        
        -- Ŀ���� ���ؼ� Ŀ���� ���ǿ� �����Ͽ� ��ȸ��
        for v in c1(v_eno) loop
            dbms_output.put_line(v.eno || ' | ' || v.ename || ' | ' || v.job || ' | ' || v.salary);
        end loop;
    end;
    /
    
    declare
        v_job employee.job%rowtype;
        cursor c1(e_job employee.job%type) is 
        select * from employee where job = e_job;
    begin
        -- �Է�â�� ���� ������ ���� �Է���.
        v_job := &input_job; -- ����
        
        -- Ŀ���� ���ؼ� Ŀ���� ���ǿ� �����Ͽ� ��ȸ��
        for v in c1(v_job) loop
            dbms_output.put_line(v.eno || ' | ' || v.ename || ' | ' || v.job || ' | ' || v.salary);
        end loop;
    end;
    /    
    
/*
< ���� ó�� ��� >
 - ����(����) - �������� ����
 - ���� - ������ �� �߻��ϴ� ����

< ���� �ڵ�� ���� �޽��� >
 - sqlcode : ���� �ڵ�
 - sqlerrm : ���� �޼���
  
< ���� ó�� >
 - ���� ó���� �Ǹ� ������ �ڵ�� �������� ����.
 
 < PL/SQL�� ������ ���� >
  - access_into_null : ora-06530 : �ʱ�ȭ���� ���� �Ӽ��� �Ҵ�
  - case_not_found : ora-06592 : case���� where���̳� else���� ���� ���
  - collection_is_null : ora-06531 : collection���� �ʱ�ȭ���� ���� ���� �Ҵ�
  - cursor_already_open : ora-06511 : �̹� Ŀ���� open�� �� ���
  - dup_val_on_index : ora-00001 : unique �ε����� �ߺ����� �Է��� ���
  - invalid_cursor : ora-01001 : Ŀ���� �߸� ����Ͽ��� ���(ex, open���� ���� Ŀ���� ����ϰų�, close�ϴ� ���)
  - invalid_number : ora-01722 : ���ڿ��� ���ڷ� �߸� ��ȯ�� ���
  - login_denied : ora-01017 : �α��ο� �������� ���
  - no_data_found : ora-01403 : select ~ into���� ������� ���� ���
  - not_logged_on : ora-01012 : �����ͺ��̽��� ���ӵ��� ���� ���
  - program_error : ora-06501 : PL/SQL ���ο� ������ �߻��� ���
  - rowtype_mismatch : ora-06504 : ����� ������ Ŀ�� ������ Ÿ���� ���� �ʴ� ���
  - self_is_null : ora-30625 : �ʱ�ȭ ���� ���� ��ü�� ����� ���
  - storage_error : ora-06500 : PL/SQL�� �޸𸮰� �����ϰų� ������ �߻��� ���
  - subscript_beyond_count : ora-06533 : �÷����� ��Һ��� ū �ε����� ����� ���
  - sys_invalid_rowid : ora-01410 : ���ڿ��� rowid�� ��ȯ�� �� ���� �������� ���� ���
  - timeout_on_resource : ora-00051 : �ڿ��� ���� ���ð��� �ʰ��� ���
  - too_many_rows : ora-01422 : select ~ into ���� ������� ����ġ�� ���� ���
  - value_error : ora-06502 : ���, Ÿ���� ��ȯ, �������� ��� ������ �߻��� ���
  - zero_divide : ora-01476 : ���ڸ� 0���� �������� �ϴ� ���

*/  

-- ���� ��Ȳ: ������ Ÿ���� ��ġ���� �ʴ� ��� 
    declare
        v_ename number;
    begin
        select ename into v_ename
        from employee
        where eno = 7788;
        
        dbms_output.put_line('7788 �����: ' || v_ename); -- ������ �ƴ� ����.
    end;
    /

-- ���� ó�� 1�� - 1������ ���ܰ� �߻����� ��
    declare
        v_ename number;
    begin
        select ename into v_ename
        from employee
        where eno = 7788;
        
        dbms_output.put_line('7788 �����: ' || v_ename);
    exception
        when value_error then
            dbms_output.put_line('���� �߻�: ������ Ÿ���� ����ġ ���� �߻�');
    end;
    /

declare
    v_ename number;
begin
    select ename into v_ename
    from employee
    where eno = 7788;
    
    dbms_output.put_line('7788 �����: ' || v_ename);
exception
    when value_error then
        dbms_output.put_line('���� �߻�: ������ Ÿ���� ����ġ ���� �߻�');
        dbms_output.put_line('���� ��ȣ: ' || sqlcode);
        dbms_output.put_line('���� �޽���: ' || sqlerrm);
        dbms_output.put_line('���� �߻� �ð�: ' || to_char(sysdate, 'YYYY/MM/DD AM HH:MI:SS'));
    when too_many_rows then 
        dbms_output.put_line('���� �߻�: ����ġ�� ���� ���� ����');
    when others then 
        dbms_output.put_line('���� �߻�: �� �� ���� ���� �߻�');
end;
/
   
   
/*
PL/SQL - Procedural Language / Structured Query Language
< ���ν��� > procedure
 - Stored Procedure, ����� ���ν���
 - PL/SQL�� �ۼ��� �Ϸ��� �۾����� �ٽ� ����� �� �ֵ��� ��ü�� ������ ��.
 - EX) Procedure, Function, Trigger
 
< ���ν����� ���� >
 - ������ SQL�� ������ ���α׷��� ������� ����� �� ����.
 - �����Ͽ� �ʿ��� ������ �ݺ������� ����� �� ����.

< ���ν����� �Ķ���� ��� >
 1. in ��� : �Ķ���ͷ� ���� �Է¹��� �� ����ϴ� ���, �⺻���̾ ���� ����.
 2. out ��� : �Ķ���ͷ� ���� ������ �� ����ϴ� ���
 3. inout ��� : �Ķ���ͷ� ���� �Է¹ް�, ���� ������ �� ����ϴ� ��� 
*/
    
-- ����1) 'SCOTT' ����� �޿��� ���ϴ� ���ν����� �ۼ�
-- ���ν��� ����
    set serveroutput on;
    
    create procedure sp_emp01 is
        v_salary employee.salary%type;
    begin
        select salary into v_salary
        from employee
        where ename = 'SCOTT';
        
        dbms_output.put_line('SCOTT ����� �޿� : ' || v_salary);
    end;
    /
    
-- ���ν��� ����
    execute sp_emp01;
    
-- ���ν��� Ȯ��
    select * from user_procedures;
    
-- ���ν����� ���� Ȯ��    
    select * from user_source where name = 'SP_EMP01';
    
-- ���ν��� ����
    drop procedure sp_emp01;
    
    
-- ���� ���ν��� ���� �� ����
-- ������ : ������� �ٲ𶧸��� �ٽ� ���ν����� �����ؾ� �Ѵ�.
    create or replace procedure sp_emp02 is
        v_salary employee.salary%type;
        v_ename employee.ename%type;
    begin
        v_ename := 'SMITH';
        select salary into v_salary
        from employee
        where ename = 'SMITH';
        
        dbms_output.put_line(v_ename || ' ����� �޿� : ' || v_salary);
    end;
    /    
    
    execute sp_emp02;
    
-- �ذ�å : ���ν������� ������� �����ϴ� ���� �ƴ϶� ���ν��� ����ÿ� ������� �Է��ϵ��� ��.
    create or replace procedure sp_emp03(v_ename in employee.ename%type) 
        is
        v_salary employee.salary%type;
    begin
        select salary into v_salary
        from employee
        where ename = v_ename;
        
        dbms_output.put_line(v_ename || ' ����� �޿� : ' || v_salary);
    end;
    /        
    
    execute sp_emp03('KING');
    
-- ��� 4�� :out ���
    create or replace procedure sp_emp04(v_ename in employee.ename%type, v_salary out employee.salary%type) 
        is
    begin
        select salary into v_salary
        from employee
        where ename = v_ename;
        
        -- dbms_output.put_line(v_ename || ' ����� �޿� : ' || v_salary);
    end;
    /        
    
    --  variable v_salary employee.salary%type; -- ���۷��� ������ ���� �Ұ�
    -- ��Į�� ������ ����  
    variable v_salary number; 
    -- ���ν��� ����
    execute sp_emp04('SCOTT', :v_salary);
    
    -- ����� ������ ���
    print v_salary;
    
-- ��� 5�� : in out ��� Ȱ��
-- ���� 5��) ����� ������ �����ϰ�, ����� ������ 10%�� ���ʽ��� �Ͽ� ���� ������ Ȯ��

    create or replace sp_emp05(v_ename in employee.ename%type, v_salary in out employee.salary%type)
    is 
    begin
        update employee
        set salary = v_salary + v_salary*0.1
        where ename = v_ename;
        dbms_output.put_line(v_ename || '����� ������ �λ�Ǿ����ϴ�.');
    end;
    /
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
