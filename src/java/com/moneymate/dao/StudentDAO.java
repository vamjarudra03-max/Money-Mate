package com.moneymate.dao;

import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StudentDAO {

    public int getStudentId(String username) {

        String sql = "SELECT user_id FROM users WHERE username = ?";

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("user_id");

                rs.close();
                ps.close();
                con.close();

                return id;
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    public double getTotalPocketMoney(int studentId) {

        String sql = "SELECT NVL(SUM(amount), 0) "
                   + "FROM pocket_money WHERE student_id = ?";

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double amount = rs.getDouble(1);

                rs.close();
                ps.close();
                con.close();

                return amount;
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    public double getTotalExpenses(int studentId) {

        String sql = "SELECT NVL(SUM(amount), 0) "
                   + "FROM expenses WHERE student_id = ?";

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double amount = rs.getDouble(1);

                rs.close();
                ps.close();
                con.close();

                return amount;
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    public double getTotalSavings(int studentId) {

        String sql = "SELECT NVL(SUM(saved_amount), 0) "
                   + "FROM savings_goals WHERE student_id = ?";

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double amount = rs.getDouble(1);

                rs.close();
                ps.close();
                con.close();

                return amount;
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public double getTotalInvestments(int studentId) {
        String sql = "SELECT NVL(SUM(invested_amount), 0) FROM investments WHERE student_id = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                double amount = rs.getDouble(1);
                rs.close();
                ps.close();
                con.close();
                return amount;
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}