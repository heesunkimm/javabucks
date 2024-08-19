package com.project.javabucksAdmin.util;

import java.util.UUID;

public class FileNameUtils {
	public static String fileNameConvert(String menuImages) {
        StringBuilder builder = new StringBuilder();
        UUID uuid = UUID.randomUUID();
        String uuidStr = uuid.toString().split("-")[0] + "_" + menuImages;
        String extension = getExtension(menuImages);

        // 파일 확장자가 없을 경우 기본 확장자를 빈 문자열로 처리
        if (extension == null || extension.isEmpty()) {
            extension = "";
        }

        builder.append(uuidStr);

        return builder.toString();
    }

    private static String getExtension(String menuImages) {
    	 int pos = menuImages.lastIndexOf(".");
         return (pos == -1) ? "" : menuImages.substring(pos + 1);
    }
}
