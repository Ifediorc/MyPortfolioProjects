SELECT TOP (1000) [id]
      ,[address_state]
      ,[application_type]
      ,[emp_length]
      ,[emp_title]
      ,[grade]
      ,[home_ownership]
      ,[issue_date]
      ,[last_credit_pull_date]
      ,[last_payment_date]
      ,[loan_status]
      ,[next_payment_date]
      ,[member_id]
      ,[purpose]
      ,[sub_grade]
      ,[term]
      ,[verification_status]
      ,[annual_income]
      ,[dti]
      ,[installment]
      ,[int_rate]
      ,[loan_amount]
      ,[total_acc]
      ,[total_payment]
  FROM [PortfolioProject].[dbo].[Bank_loan_data]

SELECT*
FROM bank_loan_data

---Total Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data

--- MTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12

SELECT COUNT(id) AS Total_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

----Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

----MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

----Previous MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11

---Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data

---MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 12

---PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11 

SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

----Average Interest Rate
SELECT AVG(int_rate) * 100 AS Avg_Int_Rate FROM bank_loan_data

SELECT ROUND(AVG(int_rate), 4) * 100 AS Avg_Int_Rate FROM bank_loan_data

SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_Avg_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-----MTD Average Interest
SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD Average Interest
SELECT AVG(int_rate)*100 AS PMTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 11

----Avg DTI (Debt-to-Income Ratio)
SELECT ROUND(AVG(dti),4)*100 AS Avg_DTI FROM bank_loan_data

SELECT ROUND(AVG(dti),4)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


SELECT*
FROM bank_loan_data

---MTD Avg DTI
SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12

----PMTD Avg DTI
SELECT AVG(dti)*100 AS PMTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 11

---GOOD LOAN ISSUED
----Good Loan Percentage

SELECT*
FROM bank_loan_data

SELECT Loan_status
FROM bank_loan_data

SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

SELECT*
FROM Bank_loan_data
----Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

---Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

---Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT*
FROM Bank_loan_data

---BAD LOAN ISSUED
----Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

SELECT*
FROM Bank_loan_data
---Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'
 
--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'
 
---Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off'

SELECT*
FROM Bank_loan_data

--------LOAN STATUS
SELECT loan_status, COUNT(id) AS LoanCount, SUM(total_payment) AS Total_Amount_Received, SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate, AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status

SELECT loan_status, SUM(total_payment) AS MTD_Total_Amount_Received, SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
--WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

SELECT*
FROM Bank_loan_data

---BANK LOAN REPORT OVERVIEW
SELECT MONTH(issue_date) AS Month_Munber, DATENAME(MONTH, issue_date) AS Month_name, COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount, SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

------STATE
SELECT address_state AS State, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

SELECT*
FROM Bank_loan_data

---TERM
SELECT term AS Term, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

---EMPLOYEE LENGTH
SELECT emp_length AS Employee_Length, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

SELECT*
FROM Bank_loan_data

---PURPOSE
SELECT purpose AS PURPOSE, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose


---HOME OWNERSHIP
SELECT home_ownership AS Home_Ownership, COUNT(id) AS Total_Loan_Applications, SUM(loan_amount) AS Total_Funded_Amount, 
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership



