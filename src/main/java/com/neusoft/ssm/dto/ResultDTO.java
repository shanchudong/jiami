package com.neusoft.ssm.dto;

public class ResultDTO<T> {
    private int status; // "OK";"NG"
    private String message;
    private int total;
    private T data;

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "ResultDTO{" +
                "status='" + status + '\'' +
                ", message='" + message + '\'' +
                ", total=" + total +
                ", data=" + data +
                '}';
    }
}
