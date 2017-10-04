package com.ketnoivantai.model.pojo;

import android.os.Parcel;
import android.os.Parcelable;

/**
 * Created by AnhVu on 9/14/16.
 */
public class String implements Parcelable {

    private final int id;
    private final int vehicle_id;
    private final java.lang.String start_date;
    private final java.lang.String arrive_date;
    private final java.lang.String start_address;
    private final java.lang.String arrive_address;
    private final int status;
    private final int price_per_unit;
    private final int driver_id;
    private final int company_id;
    private final java.lang.String company_name;
    private final java.lang.String vehicle_type;
    private final java.lang.String plate_number;
    private final int capacity_number;
    private final java.lang.String vehicle_information;

    public String(int id, int vehicle_id, java.lang.String start_date, java.lang.String arrive_date, java.lang.String start_address,
                  java.lang.String arrive_address, int status, int price_per_unit, int driver_id, int company_id,
                  java.lang.String company_name, java.lang.String vehicle_type, java.lang.String plate_number, int capacity_number,
                  java.lang.String vehicle_information) {

        this.id = id;
        this.vehicle_id = vehicle_id;
        this.start_date = start_date;
        this.arrive_date = arrive_date;
        this.start_address = start_address;
        this.arrive_address = arrive_address;
        this.status = status;
        this.price_per_unit = price_per_unit;
        this.driver_id = driver_id;
        this.company_id = company_id;
        this.company_name = company_name;
        this.vehicle_type = vehicle_type;
        this.plate_number = plate_number;
        this.capacity_number = capacity_number;
        this.vehicle_information = vehicle_information;
    }


    public int getId() {
        return id;
    }

    public int getVehicle_id() {
        return vehicle_id;
    }

    public java.lang.String getStart_date() {
        return start_date;
    }

    public java.lang.String getArrive_date() {
        return arrive_date;
    }

    public java.lang.String getStart_address() {
        return start_address;
    }

    public java.lang.String getArrive_address() {
        return arrive_address;
    }

    public int getStatus() {
        return status;
    }

    public int getPrice_per_unit() {
        return price_per_unit;
    }

    public int getDriver_id() {
        return driver_id;
    }

    public int getCompany_id() {
        return company_id;
    }

    public java.lang.String getCompany_name() {
        return company_name;
    }

    public java.lang.String getVehicle_type() {
        return vehicle_type;
    }

    public java.lang.String getPlate_number() {
        return plate_number;
    }

    public int getCapacity_number() {
        return capacity_number;
    }

    public java.lang.String getVehicle_information() {
        return vehicle_information;
    }


    @Override
    public java.lang.String toString() {
        return "String{" +
                "id=" + id +
                ", vehicle_id=" + vehicle_id +
                ", start_date='" + start_date + '\'' +
                ", arrive_date='" + arrive_date + '\'' +
                ", start_address='" + start_address + '\'' +
                ", arrive_address='" + arrive_address + '\'' +
                ", status=" + status +
                ", price_per_unit=" + price_per_unit +
                ", driver_id=" + driver_id +
                ", company_id=" + company_id +
                ", company_name='" + company_name + '\'' +
                ", vehicle_type='" + vehicle_type + '\'' +
                ", plate_number='" + plate_number + '\'' +
                ", capacity_number=" + capacity_number +
                ", vehicle_information='" + vehicle_information + '\'' +
                '}';
    }


    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        dest.writeInt(this.id);
        dest.writeInt(this.vehicle_id);
        dest.writeString(this.start_date);
        dest.writeString(this.arrive_date);
        dest.writeString(this.start_address);
        dest.writeString(this.arrive_address);
        dest.writeInt(this.status);
        dest.writeInt(this.price_per_unit);
        dest.writeInt(this.driver_id);
        dest.writeInt(this.company_id);
        dest.writeString(this.company_name);
        dest.writeString(this.vehicle_type);
        dest.writeString(this.plate_number);
        dest.writeInt(this.capacity_number);
        dest.writeString(this.vehicle_information);
    }

    protected String(Parcel in) {
        this.id = in.readInt();
        this.vehicle_id = in.readInt();
        this.start_date = in.readString();
        this.arrive_date = in.readString();
        this.start_address = in.readString();
        this.arrive_address = in.readString();
        this.status = in.readInt();
        this.price_per_unit = in.readInt();
        this.driver_id = in.readInt();
        this.company_id = in.readInt();
        this.company_name = in.readString();
        this.vehicle_type = in.readString();
        this.plate_number = in.readString();
        this.capacity_number = in.readInt();
        this.vehicle_information = in.readString();
    }

    public static final Parcelable.Creator<String> CREATOR = new Parcelable.Creator<String>() {
        @Override
        public String createFromParcel(Parcel source) {
            return new String(source);
        }

        @Override
        public String[] newArray(int size) {
            return new String[size];
        }
    };
}
