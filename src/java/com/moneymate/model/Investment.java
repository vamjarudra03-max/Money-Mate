package com.moneymate.model;

import java.sql.Date;

public class Investment {
    private int investmentId;
    private int studentId;
    private String investmentType;
    private String investmentName;
    private double investedAmount;
    private Date investmentDate;

    public int getInvestmentId() { return investmentId; }
    public void setInvestmentId(int investmentId) { this.investmentId = investmentId; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public String getInvestmentType() { return investmentType; }
    public void setInvestmentType(String investmentType) { this.investmentType = investmentType; }

    public String getInvestmentName() { return investmentName; }
    public void setInvestmentName(String investmentName) { this.investmentName = investmentName; }

    public double getInvestedAmount() { return investedAmount; }
    public void setInvestedAmount(double investedAmount) { this.investedAmount = investedAmount; }

    public Date getInvestmentDate() { return investmentDate; }
    public void setInvestmentDate(Date investmentDate) { this.investmentDate = investmentDate; }
}
