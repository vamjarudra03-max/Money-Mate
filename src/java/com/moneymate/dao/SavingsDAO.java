package com.moneymate.dao;

import com.moneymate.model.SavingsGoal;
import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SavingsDAO {
    
    public boolean addSavingsGoal(int studentId, String goalName, double targetAmount, double savedAmount) {
        String sql = "INSERT INTO savings_goals (goal_id, student_id, goal_name, target_amount, saved_amount) "
                   + "VALUES (savings_goal_seq.NEXTVAL, ?, ?, ?, ?)";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setString(2, goalName);
            ps.setDouble(3, targetAmount);
            ps.setDouble(4, savedAmount);
            int result = ps.executeUpdate();
            ps.close();
            con.close();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<SavingsGoal> getSavingsGoals(int studentId) {
        List<SavingsGoal> list = new ArrayList<>();
        String sql = "SELECT * FROM savings_goals WHERE student_id = ? ORDER BY goal_id DESC";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SavingsGoal g = new SavingsGoal();
                g.setGoalId(rs.getInt("goal_id"));
                g.setStudentId(rs.getInt("student_id"));
                g.setGoalName(rs.getString("goal_name"));
                g.setTargetAmount(rs.getDouble("target_amount"));
                g.setSavedAmount(rs.getDouble("saved_amount"));
                list.add(g);
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
