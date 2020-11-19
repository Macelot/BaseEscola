DATEDIFF(data1,data2)
MAX
MIN
AVG
HAVING
SUM
DISTINCT
COUNT
SUBSTRING
 
CREATE TABLE IF NOT EXISTS `alunos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomeAluno` varchar(50) NOT NULL,
  `notaTrimestre1` int(11) NOT NULL,
  `notaTrimestre2` int(11) NOT NULL,
  `notaTrimestre3` int(11) NOT NULL,
  `dataMatricula` date NOT NULL,
  `turma` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;
INSERT INTO `alunos` (`id`, `nomeAluno`, `notaTrimestre1`, `notaTrimestre2`, `notaTrimestre3`, `dataMatricula`, `turma`) VALUES
(2, 'Kiko', 50, 60, 70, '2020-05-01', 'informática'),
(3, 'Chaves', 55, 55, 55, '2020-05-01', 'informática'),
(4, 'Chiquinha', 50, 51, 52, '2020-05-01', 'informática'),
(5, 'Nhonho', 100, 50, 0, '2020-05-01', 'informática'),
(6, 'Popis', 20, 50, 100, '2020-05-20', 'informática'),
(7, 'Godinez', 99, 99, 99, '2020-05-01', 'informática'),
(8, 'Pepito', 50, 50, 50, '2020-05-01', 'informática'),
(9, 'Xispirito', 0, 10, 20, '2020-05-01', 'informática'),
(10, 'Gomez', 100, 100, 100, '2020-05-15', 'informática');

 
CREATE TABLE IF NOT EXISTS `professores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nomeProfessor` varchar(50) NOT NULL,
  `salario` int(11) NOT NULL,
  `materia` varchar(30) NOT NULL,
  `coordenador` int(11) NOT NULL,
  `nivelEnsinoFK` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;
INSERT INTO `professores` (`id`, `nomeProfessor`, `salario`, `materia`, `coordenador`, `nivelEnsinoFK`) VALUES
(1, 'Girafales', 10000, 'português', 1, 1),
(2, 'Florinda', 8000, 'banco de dados', 1, 3),
(3, 'Clotilde', 9000, 'Lógica', 1, 3),
(4, 'Madruga', 2000, 'matemática', 1, 2),
(5, 'Bariga', 20000, 'português', 1, 1);

CREATE TABLE IF NOT EXISTS `nivelEnsinos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `orcamentoMensal` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;
INSERT INTO `nivelEnsinos` (`id`, `descricao`, `orcamentoMensal`) VALUES
(1, 'ensino fundamental', 1000),
(2, 'ensino médio', 1500),
(3, 'ensino técnico', 2000);

1)	Apresentar o aluno matriculado mais recentemente
SELECT * FROM `alunos` order by `dataMatricula` DESC Limit 1
SELECT MAX(`dataMatricula`), `nomeAluno`  FROM `alunos` group by `dataMatricula` order by `dataMatricula` DESC limit 1

2)	Apresentar a quantos dias cada aluno está matriculado
SELECT `nomeAluno`,`dataMatricula`, DATEDIFF(now(),`dataMatricula`) as tempo FROM `alunos` order by `dataMatricula`

3)	Apresentar quantos dias faz que o último aluno se matriculou:
SELECT `nomeAluno` , `dataMatricula` , DATEDIFF( NOW( ) , `dataMatricula` ) AS tempo
FROM `alunos`
ORDER BY `dataMatricula` DESC
LIMIT 1

4)	Selecione todos os níveis de ensino cujo orçamento anual seja maior que 15000,
SELECT *
FROM `nivelensinos`
WHERE `orcamentoMensal` *12 >15000

5)	Apresente a descrição de tal nível de ensino e seu orçamento anual.
SELECT `descricao` , (
`orcamentoMensal` *12
) AS `Orçamento`
FROM `nivelensinos`
WHERE `orcamentoMensal` *12 >15000

6)	Apresente o total de salários pagos, mensalmente, por nível de ensino.
SELECT descricao, SUM( salario )
FROM `professores`
INNER JOIN nivelEnsinos ON `nivelEnsinoFK` = nivelEnsinos.id
GROUP BY nivelEnsinoFK
medio 2000
técnico 17000
fund 30000

7)	Apresente o total de salários pagos, mensalmente, por nível de ensino, dos níveis de ensino que pagam mais de 9000.
SELECT descricao, SUM(salario)
FROM `professores`
INNER JOIN nivelEnsinos ON `nivelEnsinoFK` = nivelEnsinos.id
GROUP BY nivelEnsinoFK
HAVING SUM(salario)>9000

8)	Apresente todos as matérias existentes na escola, porém omita eventuais duplicidades.
SELECT DISTINCT(`materia`)
FROM `professores`

9)	Apresente o nome de todos os professores em letras minúsculas, depois em letras maiúsculas.
SELECT lower(`nomeProfessor`) FROM professores;
SELECT upper(`nomeProfessor`) FROM professores;

10)	Apresente o nome de todos os professores (somente as 5 primeiras letras).
SELECT substring(`nomeProfessor`,1,5) FROM professores;

11)	Apresente a Média, o Maior, o Menor dos Salários pagos aos professores.
SELECT AVG(`salario`) FROM `professores`;
SELECT MAX(`salario`) FROM `professores`;
SELECT MIN(`salario`) FROM `professores`;

12)	Apresente a média de salário pagos por nível de ensino.
SELECT descricao, AVG(salario)
FROM `professores`
INNER JOIN nivelEnsinos ON `nivelEnsinoFK` = nivelEnsinos.id
GROUP BY nivelEnsinoFK
F 15000
M  2000
T  8500 

13)	Retome o problema anterior, porém apresente resposta apenas para departamentos com 2 ou mais professores.
SELECT descricao, AVG(salario)
FROM `professores`
INNER JOIN nivelEnsinos ON `nivelEnsinoFK` = nivelEnsinos.id
GROUP BY nivelEnsinoFK
HAVING COUNT(*)>=2

14)	Listar nome do professor, matéria e descrição do nível de ensino onde o professor trabalha.
SELECT `nomeProfessor` , `materia` , descricao
FROM `professores`
INNER JOIN nivelEnsinos ON `nivelEnsinoFK` = nivelEnsinos.id

15)	Liste o nome, matéria e o nome do coordenador de cada professor
SELECT p1.`nomeProfessor` , p1.`materia` , P2.`nomeProfessor`
FROM `professores` P1
INNER JOIN professores P2 ON p1.`coordenador` = P2.id
