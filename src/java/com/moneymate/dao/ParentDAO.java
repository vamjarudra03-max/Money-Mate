package com.moneymate.dao;

import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ParentDAO {

    public int getParentId(String username) {
        String sql = "SELECT user_id FROM users WHERE username = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("user_id");
                rs.close(); ps.close(); con.close();
                return id;
            }
            rs.close(); ps.close(); con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getLinkedStudentId(int parentId) {
        String sql = "SELECT student_id FROM parent_student WHERE parent_id = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, parentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("student_id");
                rs.close(); ps.close(); con.close();
                return id;
            }
            rs.close(); ps.close(); con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public String getStudentName(int studentId) {
        String sql = "SELECT full_name, username FROM users WHERE user_id = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String name = rs.getString("full_name");
                if (name == null || name.isEmpty()) {
                    name = rs.getString("username");
                }
                rs.close(); ps.close(); con.close();
                return name;
            }
            rs.close(); ps.close(); con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "Unknown Student";
    }
}
