package com.moneymate.test;

import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class DBInspector {
    public static void main(String[] args) {
        try {
            Connection con = DBConnection.getConnection();
            if (con == null) {
                System.out.println("Could not connect to DB.");
                return;
            }
            DatabaseMetaData meta = con.getMetaData();
            ResultSet rs = meta.getTables(null, "MONEYMATE", "%", new String[]{"TABLE"});
            System.out.println("--- TABLES ---");
            while (rs.next()) {
                String tableName = rs.getString("TABLE_NAME");
                System.out.println("TABLE: " + tableName);
                ResultSet cols = meta.getColumns(null, "MONEYMATE", tableName, "%");
                while (cols.next()) {
                    System.out.println("  " + cols.getString("COLUMN_NAME") + " - " + cols.getString("TYPE_NAME"));
                }
                cols.close();
            }
            rs.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
