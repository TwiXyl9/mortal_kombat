package com.example.mortal_combat;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Bitmap; import android.graphics.BitmapFactory;
import android.graphics.Color;
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

public class StatisticWidgetProvider extends HomeWidgetProvider {
    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds, SharedPreferences sp) {
        for (int id : appWidgetIds) {
            RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.widget_winrate_layout);
            PendingIntent pendingIntent = HomeWidgetLaunchIntent.INSTANCE.getActivity(context, MainActivity.class, Uri.parse("myappwidget://mortal_kombat.com/chooseCharacter?widgetId=" + id + "&mode=statistic"));
            views.setOnClickPendingIntent(R.id.add_bt, pendingIntent);
            String characterJson = sp.getString(String.valueOf(id),null);
            System.out.println(id);
            Gson gson = new Gson();
            Map character = null;
            if(characterJson != null) {
                character = gson.fromJson(characterJson, Map.class);
                System.out.println(characterJson);
            }
            if (character != null){
                System.out.println(character);
                String characterPath = String.valueOf(character.get("img"));
                if(characterPath != null){

                    String characterId = String.valueOf(character.get("id"));
                    PendingIntent imgPendingIntent = HomeWidgetLaunchIntent.INSTANCE.getActivity(context, MainActivity.class, Uri.parse("myappwidget://mortal_kombat.com/characters/" + characterId));
                    views.setOnClickPendingIntent(R.id.character_info, imgPendingIntent);

                    views.setViewVisibility(R.id.add_bt, View.GONE);

                    String characterName = String.valueOf(character.get("name"));
                    System.out.println(characterName);
                    views.setTextViewText(R.id.character_name, characterName);
                    ImageHelper.setImageFromPath(characterPath,R.id.character_image,views);
                    views.setViewVisibility(R.id.character_info, View.VISIBLE);

                    Map statistic = (Map) character.get("statistic");
                    String statisticLast = "Last: " + statistic.get("statisticLast") + "%";
                    views.setTextViewText(R.id.last_stat, statisticLast);
                    String statisticHigh = "High: " + statistic.get("statisticHigh") + "%";
                    views.setTextViewText(R.id.high_stat, statisticHigh);
                    double statisticDiff = (double) statistic.get("statisticDiff");
                    String diffOutput;
                    String diffColor;
                    if(statisticDiff > 0) {
                        diffOutput = "Increase on " + statisticDiff + "%";
                        diffColor = "#4CAF50";
                    } else {
                        diffOutput = "Decrease on " + statisticDiff + "%";
                        diffColor = "#C30E14";
                    }
                    views.setTextViewText(R.id.diff_stat, diffOutput);
                    views.setTextColor(R.id.diff_stat, Color.parseColor(diffColor));

                    String statisticPath = String.valueOf(statistic.get("img"));
                    ImageHelper.setImageFromPath(statisticPath,R.id.winrate_chart,views);
                    views.setViewVisibility(R.id.statistic_info, View.VISIBLE);
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
