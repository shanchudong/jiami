package com.neusoft.ssm.exception;

@SuppressWarnings("serial")
public class FileTypeException extends UploadFileException {

	public FileTypeException(String message) {
		super(message);
	}

	public FileTypeException(String message, Throwable cause) {
		super(message, cause);
	}

}
