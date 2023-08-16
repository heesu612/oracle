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
 
 
 
 
 
 