-- �ּ�
�ڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡڡ�

--< ���� (join) >
-- - �� �� �̻��� ���̺��� �����Ͽ� ����� ��� ��
 
-- ����1) �����ȣ 7788�� �ٹ��ϴ� �μ��� �μ����� ���
--  - 1.�� ���� ���Ǹ� �ؾ� �� -> 2. �� ���� ���Ǹ� ����Ͽ� �ذ��ϵ��� ��.
  
--  1. �ΰ��� ���������� �ذ�
--   select dno from employee where eno=7788; -> 20
--   select dname from department where dno = 20; -> RESEARCH

-- ����1) �����ȣ 7788�� �ٹ��ϴ� �μ��� �μ����� ���
-- 1�� ��� -> ���̺��.�÷���
    select employee.eno, employee.ename, department.dno, department.dname
    -- dno�տ��� department.dno �̳� employee.dno�� �������. 
    from employee, department
    where employee.dno = department.dno
    and employee.eno = 7788;

-- 2�� ��� -> �ϳ��� ���̺��� �����ϴ� �÷��� ���̺���� ��������.
    select eno, ename, employee.dno, dname
    from employee, department
    where employee.dno = department.dno
    and eno = 7788;
    
-- 3�� ��� - ���̺�� ���� �˸��ƽ� ���
    select e.eno, e.ename, e.dno, d.dname
    from employee e, department d
    where e.dno = d.dno
    and e.eno = 7788;
    
-- < �������� 4���� >
-- 4�� ��� - ���̺�� ���� �˸��ƽ� ���, ������ �÷��� �˸��ƽ��� ���� ����.
 -- 1) ���� ����
 -- where���� ���� ������ ���� ���
    select eno, ename, e.dno, dname
    from employee e, department d
    where e.dno = d.dno
    and eno = 7788;
    
 -- 2) natural ����
 -- ���� ���� ������ ������� ���� -> ���� : �� ���̺��� �����ϴ� �÷����� ������ ��
 -- �˸��ƽ��� ��� �Ұ�
 -- ������ �̸����� �����ϴ� �÷��� ���ؼ��� �˸��ƽ��� ������� ����.
 -- ���� : �����ϴ� �÷����� ��õ��� ����.
    select eno, ename, dno, dname
    from employee natural join department
    where eno = 7788;
    
 -- 3) join ~ using
 -- ���� : ���� �÷����� ��õ��� �ʴ� natural ������ �������� �ذ���.
 -- �˸��ƽ��� ���Ұ�
 -- �� ���̺��� �����ϴ� �÷����� ������ �� ��� ����.
    select eno, ename, dno, dname
    from employee join department
    using(dno)
    where eno = 7788;
    
 -- 4) join ~ on (inner join)
 -- �������� ���� ������ ���
 -- �������ο����� ���������� where���� ���, join~on������ on ���� ���������� ���
 -- ���� : on������ �������Ǹ� �����.
 -- �˸��ƽ��� ���
 -- ������ �÷������� �˸��ƽ��� ������ �� �ְ�, �� ���̺� ��� �����ϴ� �÷����� ���̺��(���̾ƽ�)�� ����ؾ� ��.
    select eno, ename, d.dno, dname
    from employee e inner join department d
    on e.dno = d.dno
    where  eno = 7788;

/*
 < ������ ����(Non-Equi Join) >
 - ���������� =(equal)�� ���� ������ ����� ���̶��,
 - ������������ =�� �ƴ� ������� ���������� ����� ���
 */
 
 /*
 ���� 2) ���, �����, �޿�, �ش� �޿��� ����� ���.
 */
    select eno, ename, salary, grade
    from employee, salgrade
    where salary between losal and hisal;
    
 -- ����3) ���, �����, �޿�, �ش� �޿��� ���, �μ���ȣ, �μ����� ���.
 
    select eno, ename, salary, grade, employee.dno, dname
    from employee, salgrade, department
    where employee.dno = department.dno
    and salary between losal and hisal;
    
/*
3. ���� ����(Self Join)
 - �� ���� ���̺��� �� ���� ���̺�� �����ϰ�, �����Ͽ� ����ϴ� ���.
*/
 -- ����4) ��� ���̺��� ���, �����, �����ڹ�ȣ, �����ڸ��� ���.
    select e.eno, e.ename, m.eno, m.ename
    from employee e, employee m
    where e.manager = m.eno
    order by e.eno;
 
    select e.eno, e.ename, m.eno, m.ename
from employee e inner join employee m
on e.manager = m.eno
order by e.eno;

/*
4. �ƿ��� ����(Outer Join), �ܺ� ����
 - �̳� ������ ���� �÷��� �� ���� �ϳ��� null�̸� ����� ������� ������,
 - �ƿ��� ������ �÷��� ���� null�� ���� ���� ����ϵ��� ��.
  4-1. ����Ʈ �ƿ��� ����(left outer join), ���� �ܺ� ����
   - ���� �÷��� ����, ���� �÷��� ���� ���� null�� �� ���
  
  4-2. ����Ʈ �ƿ��� ����(right outer join), ������ �ܺ� ����
   - ������ �÷��� ����, ������ �÷��� ���� ���� null�� �� ���
  
  4-3. Ǯ �ƿ��� ����(full outer join), ��ü �ܺ� ����
   - ���� �÷��� ���� null��, ������ �÷��� ���� null���� ��� ���
*/

-- ����5) ��� ���̺��� ���, �����, �����ڹ�ȣ, �������̸��� ����Ͻÿ�.
-- �÷��� ���� null�϶��� ���� ����ϵ��� �Ͻÿ�.
-- ���� ����� ���� ���� ����϶�.
    -- 1�� - �ֱ� ���
    select e.eno, e.ename, m.eno, m.ename
    from employee e left outer join employee m
    on e.manager = m.eno
    order by e.eno;

    -- 2�� - ���� ���
    select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager = m.eno(+)
    order by e.eno;

-- ����6) ��� ���̺��� ���, �����, �����ڹ�ȣ, �������̸��� ����Ͻÿ�.
-- ������ �÷��� ���� null�϶��� ���� ����ϵ��� �Ͻÿ�.
--> ���� ������ ���� ����� ������ ����϶�.
    -- 1�� - �ֱ� ���
    select e.eno, e.ename, m.eno, m.ename
    from employee e right outer join employee m
    on e.manager = m.eno
    order by e.eno;
    
    -- 2�� - ���� ���
    select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager(+) = m.eno
    order by e.eno;

-- ����7) ��� ���̺��� ���, �����, �����ڹ�ȣ, �������̸��� ����Ͻÿ�.
-- ���ʰ� ������ �÷��� ���� null�϶� ��� ���� ����ϵ��� �Ͻÿ�.
 --> �����ڰ� ���� ����� ������ ���� ������ ���� ����� ������ ����϶�.
 
    -- 1�� - ����
    select e.eno, e.ename, m.eno, m.ename
    from employee e full outer join employee m
    on e.manager = m.eno
    order by e.eno;
    
    -- 2�� - ������������
    select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager = m.eno(+)
    union
    select e.eno, e.ename, m.eno, m.ename
    from employee e join employee m
    on e.manager(+) = m.eno;
    
    -- 3�� - ������������
    select e.eno, e.ename, m.eno, m.ename
    from employee e left outer join employee m
    on e.manager = m.eno
    union
    select e.eno, e.ename, m.eno, m.ename
    from employee e right outer join employee m
    on e.manager = m.eno;
    

-- < ���� Ȯ�� �н� >
--1. SCOTT ����� ���, �����, �μ���ȣ, �μ����� ���
-- - �˸��ƽ��� ����ϰ�, 4������ ������� ���� �ذ�
    -- 1-1.
    select eno ���, ename �����, e.dno �μ���ȣ , dname �μ���
    from employee e, department d
    where e.dno = d.dno
    and ename = 'SCOTT';
    
    -- 1-2.
    select eno ���, ename �����, e.dno �μ���ȣ , dname �μ���
    from employee natural join department
    where ename = 'SCOTT';
    
    -- 1-3.
    select eno ���, ename �����, e.dno �μ���ȣ , dname �μ���
    from employee join department
    using(dno)
    where ename = 'SCOTT';
    
    -- 1-4.
     select eno ���, ename �����, e.dno �μ���ȣ , dname �μ���
    from employee e join department d
    on e.dno = d.dno
    where ename = 'SCOTT';
    
--2. ��� ����� �����ȣ, �����, �μ��̸�, �������� ���
-- - �˸��ƽ��� ����ϰ�, �μ��̸��� �������� ��������, �μ��̸��� ���� ���� ����� �������� ��������.
-- - 4������ ������� ������ �ذ�.
    -- 2-1.
    select eno ���, ename �����, dname �μ���, loc ������
    from employee e, department d
    where e.dno = d.dno
    order by dname asc, eno desc;
    
    -- 2-2.
    select eno ���, ename �����, dname �μ���, loc ������
    from employee natural join department
    order by dname asc, eno desc;
    
    -- 2-3.
    select eno ���, ename �����, dname �μ���, loc ������
    from employee join department
    using(dno)
    order by dname asc, eno desc;
    
    -- 2-4.
    select eno ���, ename �����, dname �μ���, loc ������
    from employee e join department d
    on e.dno = d.dno
    order by dname asc, eno desc;
    
--3. 10�� �μ��� ���ϴ� ����� �μ���ȣ, ���, �����, ����, �������� ���
-- - �˸��ƽ��� ����ϰ�, 4���� ������� ���� �ذ�.
    -- 3-1.
    select e.dno �μ���ȣ, eno ���, ename �����, e.job ����, loc ������
    from employee e, department d
    where e.dno = d.dno
    and e.dno = 10;
    
    -- 3-2.
    select dno �μ���ȣ, eno ���, ename �����, job ����, loc ������
    from employee natural join department d
    where dno = 10;
    
    -- 3-3.
    select dno �μ���ȣ, eno ���, ename �����, job ����, loc ������
    from employee join department
    using(dno)
    where dno = 10;
    
    -- 3-4.
    select e.dno �μ���ȣ, eno ���, ename �����, e.job ����, loc ������
    from employee e join department d
    on e.dno = d.dno
    where e.dno = 10;
    
--4. Ŀ�̼��� ���� �� �ִ� ����� �����, �μ���, �������� ���
-- - �˸��ƽ� ���, 4���� ���
    -- 4-1.
    select ename �����, dname �μ���, loc ������
    from employee e, department d
    where e.dno = d.dno
    and commission is not null;
    
    -- 4-2.
    select ename �����, dname �μ���, loc ������
    from employee natural join department
    where commission is not null;
    
    -- 4-3.
    select ename �����, dname �μ���, loc ������
    from employee join department
    using(dno)
    where commission is not null;
    
    -- 4-4.
    select ename �����, dname �μ���, loc ������
    from employee e join department d
    on e.dno = d.dno
    where commission is not null;
    
--5. ����� A�� ���Ե� ����� ���, �����, �μ���ȣ, �μ����� ���
-- - �˸��ƽ� ��� 4���� ���.
    -- 5-1.
    select eno ���, ename �����, e.dno �μ���ȣ, dname �μ���
    from employee e, department d
    where e.dno = d.dno
    and ename like '%A%';
    
    -- 5-2.
    select eno ���, ename �����, dno �μ���ȣ, dname �μ���
    from employee natural join department
    where ename like '%A%';
    
    -- 5-3.
    select eno ���, ename �����, dno �μ���ȣ, dname �μ���
    from employee join department
    using(dno)
    where ename like '%A%';
    
    -- 5-4.
    select eno ���, ename �����, e.dno �μ���ȣ, dname �μ���
    from employee e join department d
    on e.dno = d.dno
    where ename like '%A%';

�ڡڡڡڡ�
-- < ���� Ȯ�� �н� part.2 >
 -- 6. NEW YORK�� �ٹ��ϴ� ����� �����, ����, �μ���ȣ, �μ����� ���
  -- �˸��ƽ� ���, 4���� ���
    -- 6-1.
    select ename �����, job ����, e.dno �μ���ȣ, dname �μ���
    from employee e, department d
    where e.dno = d.dno
    and loc = 'NEW YORK';
    
    -- 6-2.
    select ename �����, job ����, dno �μ���ȣ, dname �μ���
    from employee natural join department
    where loc = 'NEW YORK';
    
    -- 6-3.
    select ename �����, job ����, dno �μ���ȣ, dname �μ���
    from employee join department
    using(dno)
    where loc = 'NEW YORK';
    
    -- 6-4.
    select ename �����, job ����, e.dno �μ���ȣ, dname �μ���
    from employee e join department d
    on e.dno = d.dno
    where loc = 'NEW YORK';
    
 -- 7. SCOTT�� ������ �μ����� �ٹ��ϴ� ���� ����� �μ���ȣ, ���������� ���
 -- �������� -> ��������
    -- 7-1.
    select dno �μ���ȣ, ename ��������
    from employee
    where dno = (select dno from employee where ename = 'SCOTT');
    
    -- 7-2.
    select dno �μ���ȣ, ename ��������
    from employee natural join department
    where dno = (select dno from employee where ename = 'SCOTT');
    
    -- 7-3.
    select dno �μ���ȣ, ename ��������
    from employee join department
    using(dno)
    where dno = (select dno from employee where ename = 'SCOTT');
    
    -- 7-4.
    select e.dno �μ���ȣ, ename ��������
    from employee e join department d
    on e.dno = d.dno
    where e.dno = (select dno from employee where ename = 'SCOTT');
 
 -- 8. WARD ������� �ʰ� �Ի��� ����� ������ �Ի����� ���
  -- �Ի����� �������� �������� �Ͽ� ���
   --> �������� , ������ ����
    -- * �����
    select o.ename, o.hiredate
    from employee w, employee o
    where w.hiredate < o.hiredate
    and w.ename = 'WARD'
    order by o.hiredate;
    
    -- * ����� 2
    select o.ename, o.hiredate
    from employee w join employee o
    on w.hiredate < o.hiredate
    and w.ename = 'WARD'
    order by o.hiredate;
    
    -- 8-1.
    select ename �����, hiredate �Ի���
    from employee
    where hiredate > (select hiredate from employee where ename = 'WARD')
    order by hiredate asc;
    
    -- 8-2.
    select ename �����, hiredate �Ի���
    from employee natural join department
    where hiredate > (select hiredate from employee where ename = 'WARD')
    order by hiredate asc;
    
    -- 8-3.
    select ename �����, hiredate �Ի���
    from employee join department
    using(dno)
    where hiredate > (select hiredate from employee where ename = 'WARD')
    order by hiredate asc;
    
    -- 8-4.
    select ename �����, hiredate �Ի���
    from employee e join department d
    on e.dno = d.dno
    where hiredate > (select hiredate from employee where ename = 'WARD')
    order by hiredate asc;
  
 -- 9. �����ں��� ���� �Ի��� ����� �����, �Ի���, �������̸�, �������Ի����� ���
    -- * �����
    select e.ename �����, e.hiredate ����Ի���, m.ename �����ڸ�, m.hiredate �������Ի���
    from employee e join employee m
    on e.manager = m.eno -- ���� ����
    and e.hiredate < m.hiredate
    order by e.eno;
    
    
    -- 9-1.
    select e.eno �����ȣ,e.ename ����̸�, e.hiredate �Ի���, e.manager �����ڹ�ȣ, m.ename �������̸�, m.hiredate �������Ի���
    from employee e, employee m
    where e.dno = m.dno
    and e.manager = m.eno
    and e.hiredate < m.hiredate;
    
    -- 9-2.
    
    
    -- 9-3.
    
    -- 9-4.
    select e.eno �����ȣ,e.ename ����̸�, e.hiredate �Ի���, e.manager �����ڹ�ȣ, m.ename �������̸�, m.hiredate �������Ի���
    from employee e join employee m
    on e.dno = m.dno
    where e.manager = m.eno
    and e.hiredate < m.hiredate;
    
 -- < ���� Ȯ�� �н� Part.3 >
 -- ���� 239 ~ 240 �������� 4���� �ذ�
  -- 1. �޿�(salary)�� 2000�ʰ��� ������� �μ� ����, ��� ������ ���
  --      (dno, dname, eno, ename, salary)
  
        -- * �����1
        select e.dno, dname, eno, ename, salary
        from employee e, department d
        where e.dno = d.dno
        and salary > 2000
        order by e.dno;
        
        -- * �����2
        select dno, dname, eno, ename, salary
        from employee natural join department 
        where salary > 2000
        order by dno;
        
        -- * �����3
        select dno, dname, eno, ename, salary
        from employee join department 
        using(dno)
        where salary > 2000
        order by dno;
        
        -- * �����4
        select e.dno, dname, eno, ename, salary
        from employee e join department d
        on e.dno = d.dno
        and salary > 2000
        order by e.dno;
        
        select d.dno �μ���ȣ, dname �μ��̸�, eno ���, ename ����̸�, salary ����
        from employee e, department d
        where salary > 2000;
  
  -- 2. �� �μ��� ��� �޿�, �ִ� �޿�, �ּ� �޿�, ������� ���
  --    (dno, dname, avg_salary, max_salary, min_salary, count)
   -- -> ���ΰ� �׷����� �Բ� �����ϴ� ����
        -- * �����1
        select e.dno, dname, trunc(avg(salary)), max(salary), min(salary), count(*)
        from employee e, department d
        where e.dno = d.dno
        group by e.dno, dname;
        
        -- * �����2
        select dno, dname, trunc(avg(salary)), max(salary), min(salary), count(*)
        from employee natural join department 
        where e.dno = d.dno
        group by e.dno, dname;
        
        -- * �����3
        select dno, dname, trunc(avg(salary)), max(salary), min(salary), count(*)
        from employee join department
        using(dno)
        group by dno, dname;
        
        -- * �����4
        select e.dno, dname, trunc(avg(salary)), max(salary), min(salary), count(*)
        from employee e join department d
        on e.dno = d.dno
        group by e.dno, dname;
        
        select dno �μ���ȣ, dname �μ��̸�, round(avg(salary),2) ��ձ޿�, max(salary) "�ִ� �޿�", min(salary) "�ּ� �޿�", count(*) �����
        from employee natural join department
        group by dno,dname;
  
  -- 3. ��� �μ� ������ ��� ������ �μ� ��ȣ, ��� �̸������� �����Ͽ� ���
        -- * �����1 <left outer join >
        select d.dno, dname, eno, ename, job, salary
        from department d, employee e
        where d.dno = e.dno(+)
        order by e.dno, ename;
        
        -- * �����2 <left outer join >
        select d.dno, dname, eno, ename, job, salary
        from department d left outer join employee e
        on d.dno = e.dno
        order by e.dno, ename;
        
        -- * �����3 < right outer join >
        select d.dno, dname, eno, ename, job, salary
        from employee e, department d
        where e.dno(+) = d.dno
        order by e.dno, ename;
        
        -- * �����4 < right outer join >
        select d.dno, dname, eno, ename, job, salary
        from employee e right outer join department d
        on e.dno(+) = d.dno
        order by e.dno, ename;
        
        select * 
        from employee natural join department
        order by dno, ename;
  
  -- 4. ��� �μ� ����, ��� ����, �޿� ��� ����, �� ����� ���� ����� ������ �μ� ��ȣ,
  --    ��� ��ȣ ������ �����Ͽ� ���.
        -- * �����1 - ���� ���
        select d.dno, d.dname, e.eno, e.ename, e.manager, e.salary, e.dno, s.losal, s.hisal, s.grade, m.eno, m.ename
        from department d, employee e, salgrade s, employee m
        where d.dno = e.dno(+)
        and e.salary between s.losal(+) and s.hisal(+)
        and e.manager = m.eno(+)
        order by d.dno, e.eno;
        
        -- * �����2 - �ֱ� ���(SQL-99 ���)
        select d.dno, d.dname, e.eno, e.ename, e.manager, e.salary, e.dno, s.losal, s.hisal, s.grade, m.eno, m.ename
        from department d
        left outer join employee e on d.dno = e.dno
        left outer join salgrade s on e.salary between s.losal and s.hisal
        left outer join employee m on e.manager = m.eno
        order by d.dno, e.eno;
        
        /*
        department d, employee e, salgrade s, employee m
        where d.dno = e.dno(+)
        and e.salary between s.losal(+) and s.hisal(+)
        and e.manager = m.eno(+)
        order by d.dno, e.eno;
        */
        
        select distinct * 
        from employee natural join department, salgrade
        where salary between losal and hisal
        order by dno, eno;