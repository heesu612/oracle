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

- exists : ���������� ������� �ϳ� �̻�(�ϳ���) �����Ѵٸ� ����� ���
 --> ���������� ���� ������ ���� ���������� ������ ���� ������ ������ �� ���, ���� ��Ȥ ����.

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
-- # ������ ��������
-- 1. ������ ANALYST�� ������� ������ �����鼭 ������ ANALYST�� �ƴ� ����� ���, �����, ����, ������ ���
    select eno, ename, job, salary
    from employee
    where job <> 'ANALYST'
    and salary <any (select salary from employee where job = 'ANALYST');

-- # ������ ��������
-- 2. BLAKE�� ������ �μ��� ���� ����� �����, �Ի���, �μ���ȣ�� ��� BLAKE����� ����
    select ename, hiredate, dno
    from employee
    where dno = (select dno from employee where ename = 'BLAKE')
    and ename <> 'BLAKE';

-- # ������ ��������
-- 3. ������ ��տ������� ���� ����� ���, �����, ������ ���. ������ ���� ��������
    select eno, ename, salary
    from employee
    where salary > (select avg(salary) from employee)
    order by salary asc;

-- # ������ ��������
-- 4. �̸��� K�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� ���, �����, �μ���ȣ�� ���
    select eno, ename, dno
    from employee
    where dno =any (select dno from employee where ename like '%K%');

-- # ������ ��������
-- 5. �μ���ġ�� DALLAS�� ����� �����, �μ���ȣ, ������ ���.
    select ename, dno, job
    from employee
    where dno = (select dno from department where loc = 'DALLAS');
    
    -- �������� �ذ�
    select ename, e.dno, job
    from employee e, department d
    where e.dno = d.dno
    and loc = 'DALLAS';
    
-- < �������� Ȯ���н� Part.3 >

-- # ������ ��������
-- 1. KING�� �����ڰ� �Ǵ� ����� �̸��� ������ ���
    select ename, salary
    from employee
    where manager = (select eno from employee where ename = 'KING');
    
    -- ���� ����
    select e.ename, e.salary
    from employee e, employee k
    where e.manager = k.eno
    and k.ename = 'KING';
    
    select e.ename, e.salary
    from employee e join employee k
    on e.manager = k.eno
    and k.ename = 'KING';
    
-- # ������ ��������
-- 2. RESEARCH �μ����� �ٹ��ϴ� ����� �μ���ȣ, �����, ������ ���
    select dno, ename, job
    from employee
    where dno = (select dno from department where dname = 'RESEARCH');
    
    -- ��������
    select e.dno, ename, job
    from  employee e, department d
    where e.dno = d.dno
    and dname = 'RESEARCH';

-- # ������ ��������
-- 3. ��տ������� ���� ������ �ް�, �̸��� M�� ���Ե� ����� ���� �μ����� �ٹ��ϴ� ����� ���, �����, ���� ���
    -- select avg(select) from employee; -->10, 20, 30
    select eno, ename, salary
    from employee
    where salary >any (select avg(salary) from employee)
    and dno =any (select dno from employee where ename like '%M%');

-- # ������ ��������
-- 4. ��տ����� ���� ���� ������ ������ ��տ����� ���
    select job, trunc(avg(salary))
    from employee
    group by job
    having avg(salary) in (select min(avg(salary)) from employee group by job);
    
    -- �����
    select job, trunc(avg(salary)) from employee
    group by job
    having avg(salary) = (select min(avg(salary)) from employee group by job);
    
-- # ������ ��������
-- 5. ������ MANAGER�� ����� ���� �μ��� ���� �μ����� �ٹ��ϴ� ����� �����, ������ ���
    select ename, job
    from employee
    where dno in (select dno from employee where job = 'MANAGER');

-- < �������� Ȯ���н� Part.4 >
-- ���� 262~263�������� 4���� �ذ�

-- # ������ ��������
-- 1. ��������, ��������
    select job, eno, ename, salary, e.dno, dname
    from employee e, department d
    where e.dno = d.dno
    and job = (select job from employee where ename = 'ALLEN';
    
    -- ��������, ��������
    select o.job, o.ename, o.salary, o.dno, dname
    from employee e, department d, employee o
    where e.dno = d.dno -- ��������
    and e.job = o.job -- ��������
    and e.ename = 'ALLEN'; 
    
-- # ������ ��������
-- 2. ��������, ����������, ��������
    select eno, ename, dname, to_char(hiredate, 'yyyy-mm-dd') "HIREDATE", loc, salary, grade
    from employee e, department d, salgrade s
    where e.dno = d.dno
    and salary between losal and hisal
    and salary > (select avg(salary) from employee)
    order by salary desc, ename;

-- # ������ ��������
-- 3. ��������, ��������
    select eno, ename, job, e.dno, dname, loc
    from employee e, department d
    where e.dno = d.dno -- ���� ����
    and e.dno = 10
    and job not in (select job from employee where dno = 30);
    

-- # ������ ��������
-- 4. ����������, ��������
    select eno, ename, salary, grade
    from employee e, salgrade s 
    where salary  between losal and hisal
    and salary > (select max(salary) from employee where job = 'SALESMAN')
    order by eno;
    
    -- ���� ������ �������� �ذ��Ѵٸ�.
    select eno, ename, salary, grade
    from employee e, salgrade s 
    where salary  between losal and hisal
    and salary >all (select salary from employee where job = 'SALESMAN')
    order by eno;
    
















