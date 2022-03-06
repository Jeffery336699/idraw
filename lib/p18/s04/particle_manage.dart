import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'particle.dart';

/// create by 张风捷特烈 on 2020/11/7
/// contact me by email 1981462002@qq.com
/// 说明:

class ParticleManage with ChangeNotifier {
  List<Particle> particles = [];
  Random random = Random();

  Size size;

  ParticleManage({this.size= Size.zero});

  void setParticles(List<Particle> particles) {
    this.particles = particles;
  }

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
    for (int i = 0; i < particles.length; i++) {
      doUpdate(particles[i]);
    }
    notifyListeners();
  }

  void doUpdate(Particle p) {
    p.vy += p.ay; // y加速度变化
    p.vx += p.ax; // x加速度变化
    p.x += p.vx;
    p.y += p.vy;

    if (p.x > size.width) {
      p.x = size.width;

      var newSize = p.size / 2;
      if (newSize > 1) {// 如果尺寸小于 1 ，执行分裂
        Particle p0 =
        p.copyWith(size: newSize, vx: -p.vx, vy: -p.vy, color: randomRGB());
        particles.add(p0);
        p.size = newSize;
        p.vx = -p.vx;
      }
    }

    if (p.x < 0) {
      p.x = 0;
      p.vx = -p.vx;
    }

    if (p.y > size.height) {
      p.y = size.height;

      var newSize = p.size / 2;
      if (newSize > 1) {
        Particle p0 =
            p.copyWith(size: newSize, vx: -p.vx, vy: -p.vy, color: randomRGB());
        particles.add(p0);
        p.size = newSize;
        p.vy = -p.vy;
      }
    }
    if (p.y < 0) {
      p.y = 0;
      p.vy = -p.vy;
    }
  }

  void reset() {
    particles.forEach((p) {
      p.x = 0;
    });
    notifyListeners();
  }

  Color randomRGB({
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(255, r, g, b); //生成argb模式的颜色
  }
}
