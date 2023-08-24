/*
< PL/SQL >
 - Programming SQL
 - SQL������ �����ϱ� ����� �۾��� �����ϱ� ���� ���α׷��� ���.
 - ����, �ݺ���, ���ǹ�, ����ó�� ���� �̿��Ͽ� �پ��� ������� SQL���� ������ �� ����.
 
< PL/SQL�� ���� >
 - declare, begin, exception�� 3���� ������ ����.
 - declare, exception ���� ���� ����, begin�� �ʼ�.
 
 declare --> ����� : ���� �Ǵ� ����� ����
 
 begin --> ����� : ���ǹ�, �ݺ���, �Լ� ���� ���� �������� ���α׷����� ������ ���
 
 exception --> ����ó���� : ����ο��� ���ܰ� �߻����� �� ó��
 
 end;
 
< PL/SQL�� �ۼ��� ���� ��Ģ >
 - �� ���ڰ� ���������� �����ݷ��� ���.
 - end �ڿ� �����ݷ��� ����Ͽ� ���� �����ٴ� ���� �����
 - �������� ������ ���� �ݵ�� /�� �Է��ؾ� ��.
 - ���� ����� ȭ������ ����ϱ� ���ؼ��� set serveroutput on;�̶�� ����� ����ؾ� ��.
 - begin �� �ȿ��� ������ ����ϱ� ���� �Լ��� dbms_output.put_line()�Լ��� �����.
 - �ּ��� --(���� �ּ�), /* */--(������ �ּ�)�� ����� �� ����.
/* 
< PL/SQL�� ���� >
 := -> �Ҵ� ������
 constant -> ����� ������ �� ���
 
< PL/SQL�� ������ Ÿ�� >
 1.  ��Į�� Ÿ�� (scalar type)
  - ����Ŭ���� ����ϴ� �⺻���� ������ Ÿ��
  - number(����), varchar2(����), date(��¥), boolean(��)
 2. ���۷��� Ÿ�� (reference type)
  - �����ͺ��̽��� �����ϴ� Ư�� ���̺��� �÷� �Ѱ� �Ǵ� ����ü�� �����ϴ� ������ Ÿ�� 
  - %type : �÷� 1��, %rowtype : �� ��ü
 
< PL/SQL������ �������� ����ϴ� ��� >
 - ����, �ѱ�, ����, ��ȣ($, #, _) ��� ����
 - ���ڴ� ù���ڷδ� ����� �� ����
 - ���� ��ҹ��ڸ� �������� ����
 - ������ ��� �Ұ�
 - ������ ��� �Ұ�
 - 30byte ���Ϸ� ��� ����
*/

-- ����1)
    set serveroutput on;
    begin
        dbms_output.put_line('Welcome to PL/SQL');
    end;
    /
    
-- ����2) ��� ���̺��� ����� 7788�� ����� �̸��� ����Ͻÿ�.
    declare
        v_eno number(4) := 7788; -- ���� ����� ���ÿ� ���� �Ҵ�.(���ʷ� ���� �Ҵ� = �ʱ�ȭ)
        v_ename varchar2(10);    -- ���� ����
    begin
        v_ename := 'SCOTT'; -- ������ ���� �Ҵ�
        dbms_output.put_line('���: ' || v_eno || ', �����: ' || v_ename);
    end;
/

-- ���� 3) SCOTT ����� ������ 3000�������� ���� 10%�� ������ ���� ������ ���
    declare
        v_name varchar2(10) := 'SCOTT'; -- ���� ���� �� �ʱ�ȭ
        v_salary number(7,2); -- ���� ����
        v_salary2 number(7,2); -- ���� ����
        v_tax number(4,2) := 0.1; -- ��� ���� �� �ʱ�ȭ
    begin
        v_salary := 3000; -- ���� ����
        v_salary2 := v_salary - v_salary * v_tax;
        dbms_output.put_line(v_name || ' ���� ���� : ' || v_salary2);
    end;
    /

-- ���� 4) 10�� �μ��� �μ����� '������'�� ���.
    declare
        v_dno number(2) not null := 10; -- not null ����
        v_dname varchar2(10) not null default '������'; -- �⺻�� ����
    begin
        dbms_output.put_line(v_dno || '�� �μ� : ' || v_dname);
    
    end;
    /

-- ����5) ����� 7369�� SMITH ����� ����� ������� ���
    declare
        v_eno employee.eno%type; -- ���۷��� ���� ���� (�÷� �Ѱ�)
        v_ename employee.ename%type;
    begin
        v_eno := 7369;
        v_ename := 'SMITH';
        dbms_output.put_line('��� : ' || v_eno || ', ����� : ' || v_ename);
    end;
    /

-- ����6) 30�� �μ��� �μ� ������ ��� (�μ���ȣ, �μ���, ������)
 -- 1�� ��� : %type (�÷� 1��)
    declare
        v_dno department.dno%type;
        v_dname department.dname%type;
        v_loc department.loc%type;
    begin
        select dno, dname, loc into v_dno, v_dname, v_loc
        from department
        where dno = 30;
        dbms_output.put_line(v_dno || ' | ' || v_dname || ' | ' || v_loc);
    end;
    /

 -- 2�� ��� : %rowtype (�� ��ü)
    declare
        v_dept department%rowtype; -- rowtype: ����ü
    begin
        select dno, dname, loc into v_dept
        from department
        where dno = 30;
    
        dbms_output.put_line(v_dept.dno || ' | ' || v_dept.dname || ' | ' || v_dept.loc);
    end;
    /

-- ����7) ��� ���̺��� Ȱ���Ͽ� ����� 7902�� ����� ���, �����, ����, �Ի���, ������ ���
-- 3���� ���(��Į�� ����, ���۷��� ����(%type, %rowtype))

-- 1�� ��� : ��Į�� ����
    declare
        v_eno number(4);
        v_ename varchar2(10);
        v_job varchar2(15);
        v_hiredate varchar2(20);
        v_salary number(7,2);
    begin
        select eno, ename, job, hiredate, salary 
        into v_eno, v_ename, v_job, v_hiredate, v_salary
        from employee
        where eno = 7902;
        
        dbms_output.put_line('��� | ����� | ���� | �Ի��� | ����');
        dbms_output.put_line('-----------------------------------');
        dbms_output.put_line(v_eno || ' | ' || v_ename || ' | ' || v_job || '|' || v_hiredate || '|' || v_salary);
    end;
    /

-- 2�� ��� : ���۷��� ���� (%type)
   declare
        v_eno employee.eno%type;
        v_ename employee.ename%type;
        v_job employee.job%type;
        v_hiredate employee.hiredate%type;
        v_salary employee.salary%type;
    begin
        select eno, ename, job, hiredate, salary 
        into v_eno, v_ename, v_job, v_hiredate, v_salary
        from employee
        where eno = 7902;
        
        dbms_output.put_line('��� | ����� | ���� | �Ի��� | ����');
        dbms_output.put_line('-----------------------------------');
        dbms_output.put_line(v_eno || ' | ' || v_ename || ' | ' || v_job || '|' || v_hiredate || '|' || v_salary);
    end;
    /

-- 3�� ��� : ���۷��� ���� (%rowtype)
    declare
        v_emp employee%rowtype;
    begin
        select *
        into v_emp
        from employee
        where eno = 7902;
        
        dbms_output.put_line('��� | ����� | ���� | �Ի��� | ����');
        dbms_output.put_line('-----------------------------------');
        dbms_output.put_line(v_emp.eno || ' | ' || v_emp.ename || ' | ' || v_emp.job || '|' || v_emp.hiredate || '|' || v_emp.salary);
    end;
    /

/*
< ���ǹ� >
 - if��, case��
 
 1. if��
  [ ������ 1���� �� ]
  if ���� then
     ���๮
  end if;
  
  [ ������ 2���� �� ]
  if ����1 then
     ���๮;
  else
     ���๮;
  end if;
  
  [ ������ 3�� �̻��� �� ]
  if ����1 then
     ���๮;
  elsif ����2 then
     ���๮;
  else
     ���๮;
  end if;
  
*/

-- ����8) �־��� ������ ���, ����, 0������ ���θ� �Ǵ��Ͻÿ�.
    declare
        v_number number := 10;
    begin
        if v_number > 0 then
            dbms_output.put_line(v_number || '�� ����Դϴ�.');
        end if;
    end;
    /

    declare
        v_number number := -10;
    begin
        if v_number > 0 then
            dbms_output.put_line(v_number || '�� ����Դϴ�.');
        else
            dbms_output.put_line(v_number || '�� �����Դϴ�.');
        end if;
    end;
    /

    declare
        v_number number := -10;
    begin
        if v_number > 0 then
            dbms_output.put_line(v_number || '�� ����Դϴ�.');
        elsif v_number < 0 then
            dbms_output.put_line(v_number || '�� �����Դϴ�.');
        else
            dbms_output.put_line(v_number || '�Դϴ�.');
        end if;
    end;
    /

--# case��
    declare
        v_number number := 0;
    begin
        case
            when v_number > 0 then
                dbms_output.put_line(v_number || '��(��) ����Դϴ�.');
            when v_number < 0 then
                dbms_output.put_line(v_number || '��(��) �����Դϴ�.');
            else
                dbms_output.put_line(v_number || ' �Դϴ�.');
        end case;
    end;
    /

-- ����9) �־��� ���ڿ� ���� Ȧ��, ¦�� ���θ� �Ǻ�
-- 2���� ���(if��, case��)
  -- if��
    declare
        v_number number := 10;
    begin
        if mod(v_number,2) = 0 then
            dbms_output.put_line(v_number || '��(��) ¦���Դϴ�.');
        else
            dbms_output.put_line(v_number || '��(��) Ȧ���Դϴ�.');
        end if;
    end;
    /
  
  --# case�� 1��
    declare
        v_number number := 10;
    begin
        case
            when mod(v_number,2) = 0 then
                dbms_output.put_line(v_number || '��(��) ¦���Դϴ�.');
            else
                dbms_output.put_line(v_number || '��(��) Ȧ���Դϴ�.');
        end case;
    end;
    /

  --# case�� 2��
    declare
        v_number number := 10;
    begin
        case mod(v_number,2)
            when 0 then
                dbms_output.put_line(v_number || '��(��) ¦���Դϴ�.');
            else
                dbms_output.put_line(v_number || '��(��) Ȧ���Դϴ�.');
        end case;
    end;
    /

-- ����10��) �־��� ����, ����, ���� ������ ���� ������� ������ �Ǻ�
-- 3���� ���(if�� 1����, case 2����)

 -- 1��
    declare
        v_kor number := 92;
        v_eng number := 93;
        v_mat number := 93;
        v_avg number(5,2);
    begin
        v_avg := (v_kor + v_eng + v_mat) / 3;
        dbms_output.put_line('��� : ' || v_avg);
        
        if v_avg >= 90 then
            dbms_output.put_line('���� : A');
        elsif v_avg >= 80 then
            dbms_output.put_line('���� : B');
        elsif v_avg >= 70 then
            dbms_output.put_line('���� : C');
        elsif v_avg >= 60 then
            dbms_output.put_line('���� : D');
        else
            dbms_output.put_line('���� : F');
        end if;
    end;
    /
 
 -- 2��
    declare
        v_kor number := 92;
        v_eng number := 93;
        v_mat number := 93;
        v_avg number(5,2);
    begin
        v_avg := (v_kor + v_eng + v_mat) / 3;
        dbms_output.put_line('��� : ' || v_avg);
        
        case
            when v_avg >= 90 then
                dbms_output.put_line('���� : A');
            when v_avg >= 80 then
                dbms_output.put_line('���� : B');
            when v_avg >= 70 then
                dbms_output.put_line('���� : C');
            when v_avg >= 60 then
                dbms_output.put_line('���� : D');
            else
                dbms_output.put_line('���� : F');
        end case;
    end;
    /
   
 
 -- 3��
    declare
        v_kor number := 92;
        v_eng number := 93;
        v_mat number := 93;
        v_avg number(5,2);
    begin
        v_avg := (v_kor + v_eng + v_mat) / 3;
        dbms_output.put_line('��� : ' || v_avg);
        
        case trunc(v_avg/10)
            when 9 then
                dbms_output.put_line('���� : A');
            when 8 then
                dbms_output.put_line('���� : B');
            when 7 then
                dbms_output.put_line('���� : C');
            when 6 then
                dbms_output.put_line('���� : D');
            else
                dbms_output.put_line('���� : F');
        end case;
    end;
    /
   
/*
< �ݺ��� > loop��
 1. �⺻ loop��
     loop
        ���๮;
        ������;
        �ݺ����� Ż�� ����;
     end loop;
 
 2. while loop��
     while ���� loop
        ���๮;
        ������;
     end loop;
 
 3. for loop��
  - ���۰����� �������� 1�� �����ϸ鼭 ����
  - i : ���� ����, 1�� �������� ������ ���
  - reverse : �������� ���۰����� 1�� �����ϸ鼭 ����
  
    for i in ���۰�..���� loop
        ���๮;
    end loop;

 4. Ŀ���� ����� for loop��
  - # exit : �ݺ��� Ż��
  - # exit when ���� : ���ǿ� ���� �ݺ��� Ż��
  - # continue : ���๮�� ������ �� ���
  - # exit continue : ���ǿ� ���� ���๮�� ������ �� ���

*/

-- ���� 11��) 1���� 10���� 1�� �����ϴ� ���� ���
-- �⺻ loop�� - 1��
    declare
        v_num number := 1;
    begin
        loop
            dbms_output.put_line(v_num);
            v_num := v_num + 1;
            if v_num > 10 then
                exit;
            end if;
        end loop;
    end;
    /

-- �⺻ loop�� - 2��
    declare
        v_num number := 1;
    begin
        loop
            dbms_output.put_line(v_num);
            v_num := v_num + 1;
            exit when v_num > 10;
        end loop;
    end;
    /

-- while loop�� 
    declare
        v_num number := 1;
    begin
        while v_num <= 10 loop
            dbms_output.put_line(v_num);
            v_num := v_num + 1;
        end loop;
    end;
    /    

-- 3-1. for loop�� - 1��
    begin
        for i in 1..10 loop
            dbms_output.put_line(i);
        end loop;
    end;
    /    

-- 3-2. for loop�� - 2�� - reverse
    begin
        for i in reverse 1..10 loop
            dbms_output.put_line(i);
        end loop;
    end;
    /  

-- ����12��) 1���� 10���� �߿��� 3�� ����� �����ϰ� ���
 -- 1-1. for loop�� 1�� - continue�� ���
    begin
        for i in 1..10 loop
            if mod(i,3) = 0 then
                continue;
            end if;
            dbms_output.put_line(i);
        end loop;
    end;
    /

 -- 1-2. for loop�� 2�� - continue�� ���
    begin
        for i in 1..10 loop
            continue when mod(i,3) = 0;
            dbms_output.put_line(i);
        end loop;
    end;
    /

-- ���� 13) �־��� �ܿ� ���� �������� ���
-- 3���� �ݺ���

 -- 1��
    declare
        v_dan number := 5;
        v_i number := 1;
    begin
        loop
            dbms_output.put_line(v_dan || ' * ' || v_i || ' = ' || v_dan*v_i);
            v_i := v_i +1;
            exit when v_i > 9;
        end loop;
    end;
    /

 -- 2��
    declare
        v_dan number := 5;
        v_i number := 1;
    begin
        while v_i < 10 loop
            dbms_output.put_line(v_dan || ' * ' || v_i || ' = ' || v_dan*v_i);
            v_i := v_i +1;
        end loop;
    end;
    /
 
-- 3��
    declare
        v_dan number := 5;
    begin
        for i in 1..9 loop
            dbms_output.put_line(v_dan || ' * ' || i || ' = ' || v_dan*i);
        end loop;
    end;
    /

/*
< ���ڵ� > record
 - ������ Ÿ���� �ٸ� ������ �ϳ��� ��� ����ϴ� ��.
 - ����ο��� �����. 

< ��ø ���ڵ� >
 - ���ڵ� �ȿ� �Ǵٸ� ���ڵ带 �����ϴ� ���ڵ�.
*/

    declare
        -- ���ڵ� ����
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- ���ڵ� ���� ����
        dept_r RECORD_DEPT;
    begin
        --���ڵ� ���� ���� �Ҵ�
        dept_r.dno := 50;
        dept_r.dname := 'MARKETING';
        dept_r.loc := 'SEOUL';
        
        -- ���ڵ� ���� ���� ���
        dbms_output.put_line(dept_r.dno || ' | ' || dept_r.dname || ' | ' || dept_r.loc);
    
    end;
    /

-- ����14��) ���ڵ� RECORD_DEPT�� ����Ͽ� department ���̺� ���� �߰�
    declare
        -- ���ڵ� ����
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- ���ڵ� ���� ����
        dept_r RECORD_DEPT;
    begin
        --���ڵ� ���� ���� �Ҵ�
        dept_r.dno := 50;
        dept_r.dname := 'MARKETING';
        dept_r.loc := 'SEOUL';
        
        -- ���ڵ� ���� ���� department ���̺� �߰�
        insert into department values(dept_r.dno, dept_r.dname, dept_r.loc);
    end;
    /

commit;

    declare
        -- ���ڵ� ����
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- ���ڵ� ���� ����
        dept_r RECORD_DEPT;
    begin
        --���ڵ� ���� ���� �Ҵ�
        dept_r.dno := 60;
        dept_r.dname := 'SALES';
        dept_r.loc := 'BUSAN';
        
        -- ���ڵ� ���� ���� department ���̺� �߰� -> ���ڵ� ������ ���� �Ѳ����� �߰�
        insert into department values dept_r;
    end;
    /

-- ���� 16) ���ڵ� RECORD_DEPT�� ����Ͽ� department ���̺��� ������ ����
    declare
        -- ���ڵ� ����
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- ���ڵ� ���� ����
        dept_r RECORD_DEPT;
    begin
        --���ڵ� ���� ���� �Ҵ�
        dept_r.dno := 55;
        dept_r.dname := 'INFO';
        dept_r.loc := 'ILSAN';
        
        -- ���ڵ� ���� ���� ���� department ���̺��� �� ����
        update department
        set row = dept_r
        where dno = 50;
    end;
    /

commit;

-- ��ø ���ڵ��� ���

    declare
        -- ���ڵ� ����
        type RECORD_DEPT is record (
            dno number(2) not null := 50,
            dname varchar2(14),
            loc department.loc%type
        );
        -- ���ڵ� ���� : ��ø ���ڵ�� ����
        type RECORD_EMP is record (
            eno employee.eno%type,
            ename employee.ename%type,
            dept_r RECORD_DEPT -- ���ڵ� ������ ���ڵ��� ����� ��
        );
        -- ���ڵ� ���� ����
        emp_r RECORD_EMP;
    begin
        --���ڵ� ���� ���� �Ҵ�
        emp_r.eno := 8000;
        emp_r.ename := 'KIM';
        emp_r.dept_r.dno := 70;
        emp_r.dept_r.dname := 'DEVELOPMENT';
        emp_r.dept_r.loc := 'DAEJEON';
        
        -- ���ڵ� ���� ���� ���
        dbms_output.put_line(emp_r.eno || ' | ' || emp_r.ename || ' | ' || emp_r.dept_r.dno || ' | ' || emp_r.dept_r.dname || ' | ' || emp_r.dept_r.loc);
    end;
    /

/*
< �÷��� > collection
 - ������Ÿ���� ���� �������� �����͸� �����ϴ� ������Ÿ��
 - ���� �迭
 - ����ο��� �����ϰ� ����.

# ���� �迭
 - ���� ������Ÿ���� ���� �����ϴ� �迭
 - Ű�� ���� �����ϴ� ����
 - �ε���(Ű)�� ���ؼ� ���� �ҷ����� ����� �迭
 - Ű�� �ߺ����� ����.
 
< �÷��� �޼ҵ� >
 - �÷����� �ٷ� �� ����ϴ� �޼ҵ�
 - count : �÷����� ����
 - first : �÷����� ù��° �ε��� ��ȣ
 - last : �÷����� ������ �ε��� ��ȣ
 - prior(n) : n�� ���� �ε��� ��ȣ
 - next(n) : n�� ���� �ε��� ��ȣ
 - delete(n) : n�� �ε����� ���� �÷��ǿ��� ����
*/

    declare
        -- ���� �迭 ����
        type EX01_ARR is table of varchar2(10) index by pls_integer;
        -- ���� �迭 ���� ����
        txt_arr EX01_ARR;
    begin
        txt_arr(1) := 'HTML';
        txt_arr(2) := 'JAVA';
        txt_arr(3) := 'ORACLE';
        txt_arr(4) := 'JSP';
        
        dbms_output.put_line(txt_arr(1) || ', ' || txt_arr(2) || ',' || txt_arr(3) || ', ' || txt_arr(4));
    end;
    /

-- ���ڵ�� ���� �迭�� Ȱ���� ���� 1��
    declare
        -- ���ڵ� ����
        type RECORD_DEPT is record (
            dno department.dno%type,
            dname department.dname%type,
            loc department.loc%type
        );
        -- ���� �迭 ����
        type ARR_EX is table of RECORD_DEPT index by pls_integer;
        -- ���� �迭 ���� ����
        dept_arr ARR_EX;
        -- �ε��� ���� ����
        idx pls_integer := 0;
    begin
        for i in (select * from department) loop
            idx := idx + 1;
            dept_arr(idx).dno := i.dno;
            dept_arr(idx).dname := i.dname;
            dept_arr(idx).loc := i.loc;
            
            dbms_output.put_line(dept_arr(idx).dno || ' | ' || dept_arr(idx).dname || ' | ' || dept_arr(idx).loc);
        end loop;
    end;
    /

-- ���� 17) ���ڵ�� ���� �迭�� ����Ͽ�, employee ���̺��� ���, �����, ����, �޿��� ���
-- ���ڵ�� : RECORD_EMP, �����迭�� : ARR_EMP
    declare
        -- ���ڵ� ����
        type RECORD_EMP is record (
            eno employee.eno%type,
            ename employee.ename%type,
            job employee.job%type,
            salary employee.salary%type
        );
        -- ���� �迭 ����
        type ARR_EXP is table of RECORD_EMP index by pls_integer;
        -- ���� �迭 ���� ����
        emp_arr ARR_EXP;
        -- �ε��� ���� ����
        
        idx pls_integer := 0;
    begin
        dbms_output.put_line(' ��� | ����� |  ����  |  ���� ');
        for i in (select * from employee) loop
            idx := idx + 1;
            emp_arr(idx).eno := i.eno;
            emp_arr(idx).ename := i.ename;
            emp_arr(idx).job := i.job;
            emp_arr(idx).salary := i.salary;

            dbms_output.put_line(emp_arr(idx).ename || ' | ' || emp_arr(idx).ename || ' | ' || emp_arr(idx).job || ' | ' || emp_arr(idx).salary);
        end loop;
        
        dbms_output.put_line('----------------------------------');
        -- ���� �迭�� ���� ����
        emp_arr.delete(15);
        
        -- ���� �迭 �޼ҵ� Ȱ��
        dbms_output.put_line('�迭�� ���� : ' || emp_arr.count);
        dbms_output.put_line('�迭�� ù��° �� : ' || emp_arr.first);
        dbms_output.put_line('�迭�� ������ �� : ' || emp_arr.last);
        dbms_output.put_line('�迭�� 14�� ���� �ε��� : ' || emp_arr.prior(14));
        dbms_output.put_line('�迭�� 10�� ���� �ε��� : ' || emp_arr.next(10));
    end;
    /

-- ����18) employee ����� ���� �����ϴ� ���ڵ带 �����Ͽ�, ���ڵ��� ���� employee ���̺�
-- �����ϴ� PL/SQL�� �����Ͻÿ�.
-- ���ڵ��: RECORD_EMP
    declare
    -- ���ڵ� ����
    
    -- ���ڵ� ���� ����
    
    begin
    
    end;
    /




















































































































































