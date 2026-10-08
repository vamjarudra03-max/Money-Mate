package com.moneymate.test;

import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.Statement;

public class InsertRelation {
    public static void main(String[] args) {
        try {
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            stmt.executeUpdate("INSERT INTO PARENT_STUDENT (RELATIONSHIP_ID, PARENT_ID, STUDENT_ID) VALUES (1, 2, 1)");
            System.out.println("Inserted relation: Parent 2 -> Student 1");
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
