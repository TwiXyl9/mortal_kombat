package com.example.mortal_combat;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.AsyncTask;
import android.util.Log;
import android.view.View;
import android.widget.RemoteViews;

import com.google.gson.Gson;

import java.io.File;
import java.io.InputStream;
import java.util.Map;

import es.antonborri.home_widget.HomeWidgetLaunchIntent;
import es.antonborri.home_widget.HomeWidgetPlugin;
import es.antonborri.home_widget.HomeWidgetProvider;

public class CharacterWidgetProvider extends HomeWidgetProvider {
        @Override
        public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds, SharedPreferences sp) {
                for (int id : appWidgetIds) {
                        RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_character_layout);
                        PendingIntent pendingIntent = HomeWidgetLaunchIntent.INSTANCE.getActivity(context, MainActivity.class, Uri.parse("myappwidget://mortal_kombat.com/chooseCharacter?widgetId=" + id + "&mode=character"));
                        views.setOnClickPendingIntent(R.id.add_bt, pendingIntent);
                        String characterJson = sp.getString(String.valueOf(id),null);
                        Gson gson = new Gson();
                        Map map = null;
                        if(characterJson != null) {
                                map = gson.fromJson(characterJson, Map.class);
                        }
                        if (map != null){
                                System.out.println(map);
                                String imgPath = String.valueOf(map.get("img"));
                                if(imgPath != null){
                                        ImageHelper.setImageFromPath(imgPath, R.id.widget_image, views);
                                        views.setViewVisibility(R.id.widget_image, View.VISIBLE);

                                        String characterId = String.valueOf(map.get("id"));
                                        PendingIntent imgPendingIntent = HomeWidgetLaunchIntent.INSTANCE.getActivity(context, MainActivity.class, Uri.parse("myappwidget://mortal_kombat.com/characters/" + characterId));
                                        views.setOnClickPendingIntent(R.id.widget_image, imgPendingIntent);

                                        views.setViewVisibility(R.id.add_bt, View.GONE);

                                        String characterName = String.valueOf(map.get("name"));
                                        views.setTextViewText(R.id.widget_text, characterName);
                                        views.setViewVisibility(R.id.widget_text, View.VISIBLE);
                                }
                        }

                        appWidgetManager.updateAppWidget(id, views);
                }
        }

        @Override
        public void onDeleted(Context context, int[] appWidgetIds) {
                for (int id : appWidgetIds) {
                        super.onDeleted(context, appWidgetIds);
                        SharedPreferences sp = HomeWidgetPlugin.Companion.getData(context);
                        sp.edit().remove(String.valueOf(id)).apply();
                }

        }
}
