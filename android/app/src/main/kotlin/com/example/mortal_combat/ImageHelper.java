package com.example.mortal_combat;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.widget.RemoteViews;

import java.io.File;

public class ImageHelper {
    public static void setImageFromPath(String path, int id, RemoteViews views){
        File file = new File(path);
        if (file.exists()) {
            Bitmap statisticBitmap = BitmapFactory.decodeFile(file.getAbsolutePath());
            views.setImageViewBitmap(id, statisticBitmap);
        }
    }
}
