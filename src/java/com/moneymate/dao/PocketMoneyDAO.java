package com.moneymate.dao;

import com.moneymate.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class PocketMoneyDAO {

    public boolean addPocketMoney(
            int studentId,
            int parentId,
            double amount,
            String description) {

        String sql = "INSERT INTO pocket_money "
                   + "(pocket_id, student_id, parent_id, amount, description) "
                   + "VALUES (pocket_money_seq.NEXTVAL, ?, ?, ?, ?)";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, studentId);

            if (parentId > 0) {
                ps.setInt(2, parentId);
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }

            ps.setDouble(3, amount);
            ps.setString(4, description);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            return result > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }
}