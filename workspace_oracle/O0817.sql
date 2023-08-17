-- �������� ��Ʈ
-- �ڡڡڡڡڡڡڡڡڡڡڡڡڡ�
/*
< ���� ���� (Sub Query) >
 - �ٸ� ������ �ȿ� �� �ִ� ������ ���� ����.
 - ���� �������� ������ �ִ� ���� �������� ����.
 - main query : �ٱ��ʿ� �ִ� ������ 
 - sub query : ���ʿ� �� �ִ� ������, ��ȣ�� �� ������
  --> �Ϲ������� main query �ȿ� sub query�� ���Ե� ������ �������� ���� �������̶�� �θ�.
*/


-- ����1) SCOTT ������� ������ ���� ����� �̸��� ������ Ȯ��.
    -- 2���� ������ ���� ���� �ذ�
      -- 1. SCOTT ����� ������ Ȯ�� --> ��� : 3000
         select salary from employee where ename = 'SCOTT';
      -- 2. ������ 3000���� ���� ����� �̸��� ������ Ȯ��.
         select ename, salary from employee where salary > 3000;
         
    -- 1���� ������ ���ؼ� ���� �ذ�
         select ename, salary from employee
         where salary > (select salary from employee where ename = 'SCOTT');
         
    -- 1�� ������ �������� �ذ��Ѵٸ�.
        -- ���� ���� -> ��������
        select o.ename, o.salary
        from employee s, employee o
        where s.salary < o.salary
        and s.ename = 'SCOTT';
        
        select o.ename, o.salary
        from employee s join employee o
        on s.salary < o.salary
        where s.ename = 'SCOTT';

-- # ���� �� ��������
-- ����2) �ְ����� �޴� ����� �����, ����, ������ ���
         select ename, job, salary
         from employee 
         where salary = (select max(salary) from employee);

-- # ������ ��������
-- ����3) SMITH�� ������ �μ����� �ٹ��ϴ� ����� ���, �̸�, �μ���ȣ�� ���
         select eno, ename, dno
         from employee
         where dno = (select dno from employee where ename = 'SMITH');
         
         -- �������� ������ �ذ��Ѵٸ� -> ���� ���� - ��������
         select o.eno, o.ename, o.dno
         from employee s, employee o
         where s.dno = o.dno
         and s.ename = 'SMITH';
         
         select o.eno, o.ename, o.dno
         from employee s join employee o
         on s.dno = o.dno
         where s.ename = 'SMITH';

-- # ������ ��������
-- ����4) ��� ���̺��� ��տ������� ���� ������ �޴� ����� �����, ����, ������ ���
         select ename, job, salary
         from employee
         where salary < (select avg(salary) from employee);

�ڡڡ�
-- # ������ �������� 
-- ����5) �μ��� ���������� 30�� �μ��� ������������ ���� �μ��� �μ���ȣ�� ���������� ���ض�.
         select e.dno, min(salary)
         from department d, employee e
         where salary < (select min(salary) from employee where dno = 30)
         group by e.dno, salary;
         
         -- * �����
         select dno, min(salary) 
         from employee
         group by dno
         having min(salary) < (select min(salary) from employee where dno = 30);
         

-- ########
/*
< ���������� ���� >
 - ���������� ������� ������ ���� ����
    1. ������ ��������
     - ����� 1���� ����������
    2. ������ ���깹��
     - ����� 2�� �̻��� ����������
     
< ������������ ����ϴ� ������ >
 1. ������ ��
 - >, >=, <, <=, = <>
 2. ������ ��
 - in, any(some), all, exists
 - >any, >=any, <any, <=any, =any(in), <>any(not in)
 - >all, >=all, <all, <=all, =all, <>all
 - exists
 
< �����࿡���� ������ ���� >
- any: ���������� �������� ���������� ����� �ϳ��̻� ��ġ�� �� ���
- all: ���������� �������� ���������� ����� ��� ��ġ�� �� ��� 

< ������ �������������� any�� all�� ������ >
1. any(some) : ���������� ���� ��� �߿��� �� ������ �����ص� ����� ���
 - <any : ���������� ��� �߿��� �ִ밪���� ���� ���� ���
 - >any : ���������� ��� �߿��� �ּҰ����� ū ���� ���
2. all : ���������� ���� ����� ��� �����ؾ� ����� ���
 - <all : ���������� ��� �߿��� �ּҰ����� ���� ���� ���
 - >all : ���������� ��� �߿��� �ִ밪���� ū ���� ���

2. all
*/
-- # ������ ��������
-- ����6) �μ��� ���������� �޴� ����� ����� ������� ���
    -- ORA-01427: single-row subquery returns more than one row
    -- ������ �������� ���ؼ� ���� ���� ����� ó���Ͽ� �߻��ϴ� ����
         select eno, ename
         from employee
         where salary < (select min(salary) from employee group by dno);
         
    -- �ذ�å
        select dno, eno, ename from employee
        where salary in (select min(salary) from employee group by dno);
        
        select dno, eno, ename from employee
        where salary = any (select min(salary) from employee group by dno);
        
-- # ������ ��������
-- select salary from employee where job = 'SALESMAN'; --> 1600,1500,1250,1250
-- ����7) ������ SALESMAN�� �ƴϸ鼭, ������ ������ SALESMAN���� ���� ����� ���, �����, ����, ������ ���
        select eno, ename, job, salary
        from employee
        where job != 'SALESMAN'
        and salary <any (select salary from employee where job = 'SALESMAN');
        
-- # ������ ��������
-- select salary from employee where job = 'SALESMAN'; --> 1600,1500,1250,1250
-- ���� 8) ������ SALESMAN�� �ƴϸ鼭, ������ SALESMAN���� ���� ����� ���, �����, ����, ������ ���
        select eno, ename, job, salary
        from employee
        where job != 'SALESMAN'
        and salary <all (select salary from employee where job = 'SALESMAN');
        
-- #
-- ����9) �μ� ���̺��� 10�� �μ��� �μ����� �����Ѵٸ� ��� ���̺��� ��� ���� ���
    select * from employee
    where exists (select dname from department where dno = 10);

-- ����10) �μ� ���̺��� 40�� �μ��� �μ����� �����Ѵٸ� ��� ���̺��� ��� ���� ���
    select * from employee
    where exists (select dname from department where dno = 50);
         
         
-- �ڡڡڡڡ�
-- < �������� Ȯ���н� Part.1 >

-- # ������ ��������.
-- 1. �����ȣ�� 7788�� ����� ������ ���� ����� ���, �����, ������ ���.
        select eno, ename, job
        from employee
        where job = (select job from employee where eno = 7788);

-- # ������ ��������.
-- 2. �����ȣ�� 7499�� ������� ������ ���� ����� ���, �����, ����, �޿��� ���
        select eno, ename, job, salary
        from employee
        where salary > (select salary from employee where eno = 7499);

-- # ������ ��������
-- 3. �ִ�޿��� �޴� ����� �����, ����, ������ ���.
        select ename, job, salary
        from employee
        where salary = (select max(salary) from employee);

-- # ������ ��������
-- 4. ������ ���� ���� ��տ����� ������ ��տ����� ���
        select job, trunc(avg(salary))
        from employee
        group by job
        having avg(salary) = (select min(avg(salary)) from employee group by job); 
        

-- # ������ ��������
-- 5. �� �μ��� ���������� �޴� ����� �����, ����, �μ���ȣ�� ���.
        select ename, salary, dno
        from employee
        where salary in (select min(salary) from employee group by dno); 

-- # ������ ��������
-- 6. ������ ��տ����� ������ ��տ����� ���
        select job, trunc(avg(salary)) from employee
        group by job
        having avg(salary) in (select avg(salary) from employee group by job);
        
        -- �����ϰ� �ذ�
        select job, trunc(avg(salary)) from employee group by job;

-- < �������� Ȯ���н� Part.2 >
-- 1. ���ΰ� ANALST�� ������� ������ �����鼭 ������ ANALYST�� �ƴ� ����� ���, �����, ����, ������ ���
    

-- 2. BLAKE�� ������ �μ��� ���� ����� �����, �Ի���, �μ���ȣ�� ��� BLAKE����� ����

-- 3. ������ ��տ������� ���� ����� ���, �����, ������ ���. ������ ���� ��������

-- 4. �̸��� K�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� ���, �����, �μ���ȣ�� ���

-- 5. �μ���ġ�� DALLAS�� ����� �����, �μ���ȣ, ������ ���.
















