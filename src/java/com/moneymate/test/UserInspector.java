package com.moneymate.test;

import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserInspector {
    public static void main(String[] args) {
        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM USERS");
            System.out.println("--- USERS ---");
            while (rs.next()) {
                System.out.println(rs.getInt("USER_ID") + " | " + rs.getString("USERNAME") + " | " + rs.getString("ROLE"));
            }
            rs.close();
            
            System.out.println("--- PARENT_STUDENT ---");
            rs = stmt.executeQuery("SELECT * FROM PARENT_STUDENT");
            while (rs.next()) {
                System.out.println(rs.getInt("RELATIONSHIP_ID") + " | " + rs.getInt("PARENT_ID") + " | " + rs.getInt("STUDENT_ID"));
            }
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
