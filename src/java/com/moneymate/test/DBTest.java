package com.moneymate.test;

import com.moneymate.util.DBConnection;
import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        Connection con = DBConnection.getConnection();

        if (con != null) {
            System.out.println("SUCCESS: MoneyMate connected to Oracle!");
        } else {
            System.out.println("FAILED: Could not connect to Oracle.");
        }
    }
}