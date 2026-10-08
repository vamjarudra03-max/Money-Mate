package com.moneymate.dao;

import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.moneymate.model.Expense;

public class ExpenseDAO {

    public boolean addExpense(
            int studentId,
            double amount,
            String category,
            String description,
            String paymentMode) {

        String sql = "INSERT INTO expenses "
                   + "(expense_id, student_id, amount, category, description, payment_mode) "
                   + "VALUES (expenses_seq.NEXTVAL, ?, ?, ?, ?, ?)";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, studentId);
            ps.setDouble(2, amount);
            ps.setString(3, category);
            ps.setString(4, description);
            ps.setString(5, paymentMode);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            return result > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }

    public List<Expense> getExpensesByStudent(int studentId) {
        List<Expense> expenses = new ArrayList<>();
        String sql = "SELECT * FROM expenses WHERE student_id = ? ORDER BY expense_date DESC, expense_id DESC";
        
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Expense e = new Expense();
                e.setExpenseId(rs.getInt("expense_id"));
                e.setStudentId(rs.getInt("student_id"));
                e.setAmount(rs.getDouble("amount"));
                e.setCategory(rs.getString("category"));
                e.setDescription(rs.getString("description"));
                e.setPaymentMode(rs.getString("payment_mode"));
                e.setExpenseDate(rs.getDate("expense_date"));
                expenses.add(e);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return expenses;
    }
}