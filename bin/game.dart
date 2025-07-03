import 'dart:io';
import 'dart:math';

class User {
  String? username;
  int userHp;
  int userAttack;
  int userDefense;

  User({
    required this.username,
    required this.userHp,
    required this.userAttack,
    required this.userDefense,
  });
}

class Monster {
  String? monsterName;
  int monsterHp;
  int monsterAttack;

  Monster({
    required this.monsterName,
    required this.monsterHp,
    required this.monsterAttack,
  });
}

class Game {
  List<Monster> monsters = [
    Monster(monsterName: "Goblin", monsterHp: 30, monsterAttack: 5),
    Monster(monsterName: "Orc", monsterHp: 50, monsterAttack: 10),
    Monster(monsterName: "Dragon", monsterHp: 100, monsterAttack: 20),
  ];

  User player = User(
    username: "random",
    userHp: 50,
    userAttack: 10,
    userDefense: 5,
  );

  Random random = Random();

  void mainBattle() {
    print("캐릭터의 이름을 입력하세요");
    player.username = stdin.readLineSync();
    print("게임을 시작합니다!");
    print(
      "${player.username}님, 현재 체력: ${player.userHp}, 공격력: ${player.userAttack}, 방어력: ${player.userDefense}",
    );

    while (player.userHp > 0 && monsters.isNotEmpty) {
      int index = random.nextInt(monsters.length);
      Monster resultMonster = monsters[index]; // 랜덤으로 몬스터 선택
      print("몬스터가 나타났습니다!");
      print(
        "${resultMonster.monsterName} (체력: ${resultMonster.monsterHp}, 공격력: ${resultMonster.monsterAttack})",
      );

      while (player.userHp > 0 && resultMonster.monsterHp > 0) {
        print("${player.username}의 턴");
        print("행동을 선택하세요 (1: 공격하기, 2: 방어하기,)");

        String? inputDate = stdin.readLineSync();
        int choice = int.tryParse(inputDate ?? '') ?? 0;
        switch (choice) {
          case 1:
            resultMonster.monsterHp -= player.userAttack;
            print(
              "${player.username}이(가) ${resultMonster.monsterName}에게 ${player.userAttack}의 피해를 입혔습니다.",
            );
            break;

          case 2:
            player.userHp += resultMonster.monsterAttack;
            print(
              "${player.username}이(가) 방어 태세를 취하여 ${resultMonster.monsterAttack} 만큼 체력을 얻었습니다.",
            );
            break;
        }
        player.userHp -= resultMonster.monsterAttack;
        print(
          "${resultMonster.monsterName}이(가) ${player.username}에게 ${resultMonster.monsterAttack -= player.userDefense}의 데미지를 입혔습니다.",
        );
        if (resultMonster.monsterHp <= 0) {
          print("${resultMonster.monsterName}을(를) 처치했습니다!");
          monsters.remove(resultMonster);
          if (monsters.isEmpty) {
            print("다음 몬스터와 싸우시겠습니다? (y/n)");
            String? nextChoice = stdin.readLineSync();
            if (nextChoice == 'y') {
              print("다음 게임으로 이동합니다.");
              break;
            } else if (nextChoice == 'n') {
              print("게임을 종료합니다.");
              return;
            }
          } else if (monsters.isNotEmpty) {
            print("축하합니다! 모든 몬스터를 물리쳤습니다!");
          }
        } else if (player.userHp <= 0) {
          print("쓰러졌습니다. 게임 오버!");
          return;
        }
      }
    }
  }
}

void main() {
  Game game = Game();
  game.mainBattle();
}
