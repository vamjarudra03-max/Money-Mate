package com.moneymate.dao;

import com.moneymate.model.Investment;
import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class InvestmentDAO {
    
    public boolean addInvestment(int studentId, String type, String name, double amount) {
        String sql = "INSERT INTO investments (investment_id, student_id, investment_type, investment_name, invested_amount) "
                   + "VALUES (investments_seq.NEXTVAL, ?, ?, ?, ?)";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setString(2, type);
            ps.setString(3, name);
            ps.setDouble(4, amount);
            int result = ps.executeUpdate();
            ps.close();
            con.close();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Investment> getInvestments(int studentId) {
        List<Investment> list = new ArrayList<>();
        String sql = "SELECT * FROM investments WHERE student_id = ? ORDER BY investment_id DESC";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Investment i = new Investment();
                i.setInvestmentId(rs.getInt("investment_id"));
                i.setStudentId(rs.getInt("student_id"));
                i.setInvestmentType(rs.getString("investment_type"));
                i.setInvestmentName(rs.getString("investment_name"));
                i.setInvestedAmount(rs.getDouble("invested_amount"));
                i.setInvestmentDate(rs.getDate("investment_date"));
                list.add(i);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
