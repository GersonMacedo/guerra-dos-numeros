import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/databaseProvider.dart';

class MathStack{
  MathStack(this.operation, this.x, this.y, this.numbers, this.stage, this.step, this.iteration);

  String operation;
  int x, y;
  List<String> numbers;
  int stage;
  int step;
  int iteration;
}

class LevelData{
  LevelData(this.operations, this.correctBonus, this.wrongPenalty){
    question = "";
  }
  LevelData.withQuestion(this.operations, this.correctBonus, this.wrongPenalty, this.question);

  List<MathStack> operations;
  late String question;
  int startTime = 150;
  int correctBonus;
  int wrongPenalty;
}

class Levels{
  static const String title = 'Batalha dos números';

  static Random random = Random();
  static bool interpretation = true;
  static List<int> next = [1, 1];
  static int type = -1;
  static int actual = 0;
  static int size = 0;
  static List<List<bool>> levelsWithoutMistakes = [];
  static int totalWithoutMistakes = 0;

  static List<String> operators = ["+", "-", "x", "/"];
  static int operator = 0;
  static int digits = 2;
  static int time = 0;
  static List<int> correctTimeList = [90, 30, 10, 2];
  static List<int> wrongTimeList = [30, 45, 60, 90];

  static int hamburgerType = 0;
  static bool devMode = false;
  static List<int> page = [1, 1];

  static Future<void> changeHamburgerType(int newType) async {
    hamburgerType = newType;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("hamburgerType", newType);
  }

  static int getRandomNumber(){
    Random random = Random();
    return pow(10, digits - 1).toInt() + random.nextInt(pow(10, digits).toInt() - pow(10, digits - 1).toInt() - 1);
  }

  static List<int> getNumberList(int size){
    List<int> list = [];
    for(int i = 0; i < size; i++){
      list.add(getRandomNumber());
    }

    return list;
  }

  static List<String> sumQuestions = [
    "Mariazinha tinha | reais guardado, no seu aniversário ela ganhou mais | reais do seu pai. Quantos reais ela tem hoje?",
    "Ana tinha | balas e ganhou mais | balas de sua avó. Quantas balas ela tem agora?",
    "Carlos tinha | figurinhas em seu álbum e comprou mais | figurinhas na banca. Quantas figurinhas ele tem agora?",
    "Paula tinha | lápis de cor e recebeu mais | lápis de cor de sua amiga. Quantos lápis de cor ela tem agora?",
    "Pedro tinha | livros em sua estante e ganhou mais | livros de presente. Quantos livros ele tem agora?",
    "Laura tinha | reais em sua carteira e seu irmão deu mais | reais a ela. Quanto dinheiro ela tem agora?",
    "Lucas tinha | pirulitos e sua irmã deu mais | pirulitos a ele. Quantos pirulitos ele tem agora?",
    "Mariana tinha | cadernos em sua mochila e comprou mais | cadernos na papelaria. Quantos cadernos ela tem agora?",
    "Rafael tinha | carrinhos em sua coleção e ganhou mais | carrinhos de seu pai. Quantos carrinhos ele tem agora?",
    "Camila tinha | rosas em seu jardim e plantou mais | rosas esta semana. Quantas rosas ela tem agora?",
    "Bruno tinha | moedas em seu cofrinho e encontrou mais | moedas debaixo do sofá. Quantas moedas ele tem agora?",
    "Juliana tinha | bolinhas de gude e seu amigo deu mais | bolinhas de gude a ela. Quantas bolinhas de gude ela tem agora?",
    "Gabriel tinha | chocolates em sua caixa e comprou mais | chocolates na loja. Quantos chocolates ele tem agora?",
    "Sofia tinha | bonecas em sua prateleira e ganhou mais | bonecas de sua avó. Quantas bonecas ela tem agora?",
    "Eduardo tinha | CDs em sua coleção e seu irmão deu mais | CDs a ele. Quantos CDs ele tem agora?",
    "Isabela tinha | melancias em seu cesto e colheu mais | melancias no jardim. Quantas melancias ela tem agora?",
    "Carlos tinha | camisetas em seu armário e comprou mais | camisetas na liquidação. Quantas camisetas ele tem agora?",
    "Alice tinha | pipas em seu quarto e seu pai comprou mais | pipas para ela. Quantas pipas ela tem agora?",
    "João tinha | mochilas e ganhou mais | mochilas de sua mãe. Quantas mochilas ele tem agora?",
    "Laura tinha | cachorros em sua casa e sua vizinha deu mais | cachorros para ela. Quantos cachorros ela tem agora?",
    "Pedro tinha | televisores em sua loja e comprou mais | televisores para o estoque. Quantos televisores ele tem agora?",
    "Sofia tinha | canetas em sua mesa e encontrou mais | canetas na sala de aula. Quantas canetas ela tem agora?",
    "Rafael tinha | patins e ganhou mais | patins de presente. Quantos patins ele tem agora?",
    "Lucas tinha | chicletes em seu bolso e comprou mais | chicletes na cantina. Quantos chicletes ele tem agora?",
    "Maria tinha | brinquedos em sua caixa e seu amigo deu mais | brinquedos a ela. Quantos brinquedos ela tem agora?",
    "Carlos tinha | bonés em seu armário e comprou mais | bonés na loja. Quantos bonés ele tem agora?",
    "Julia tinha | pães em seu cesto e colheu mais | pães na padaria. Quantos pães ela tem agora?",
    "Pedro tinha | lápis em sua mochila e seu professor deu mais | lápis a ele. Quantos lápis ele tem agora?",
    "Laura tinha | papéis em sua gaveta e comprou mais | papéis na papelaria. Quantos papéis ela tem agora?",
    "Gabriel tinha | videogames em sua coleção e ganhou mais | videogames de seu amigo. Quantos videogames ele tem agora?",
    "Isabela tinha | gatos em sua casa e sua vizinha deu mais | gatos para ela. Quantos gatos ela tem agora?",
    "Lucas tinha | balões e ganhou mais | balões de seu irmão. Quantos balões ele tem agora?",
    "Rafael tinha | ursinhos de pelúcia em sua cama e comprou mais | ursinhos de pelúcia na loja. Quantos ursinhos de pelúcia ele tem agora?",
    "Maria tinha | abacaxis em sua geladeira e colheu mais | abacaxis no jardim. Quantos abacaxis ela tem agora?",
    "João tinha | canecas em sua prateleira e ganhou mais | canecas de sua avó. Quantas canecas ele tem agora?",
    "Laura tinha | lápis de cor em sua caixa e comprou mais | lápis de cor na papelaria. Quantos lápis de cor ela tem agora?",
  ];

  static List<String> multiplicationQuestions = [
    "Anna tem | caixas de ovos. Cada caixa tem | ovos. Quantos ovos ela tem no total?",
    "Lucas tem | cestas de maçãs. Cada cesta tem | maçãs. Quantas maçãs ele tem no total?",
    "Maria tem | pacotes de balas. Cada pacote tem | balas. Quantas balas ela tem no total?",
    "Pedro tem | estojos de lápis. Cada estojo tem | lápis. Quantos lápis ele tem no total?",
    "João tem | chapéus de palha. Cada chapéu tem | fitas. Quantas fitas ele tem no total?",
    "Sofia tem | caixas de chocolates. Cada caixa tem | chocolates. Quantos chocolates ela tem no total?",
    "Mariana tem | gavetas de meias. Cada gaveta tem | meias. Quantas meias ela tem no total?",
    "Rafael tem | vidros de tinta. Cada vidro tem | pincéis. Quantos pincéis ele tem no total?",
    "Luciana tem | caixas de lápis de cor. Cada caixa tem | lápis de cor. Quantos lápis de cor ela tem no total?",
    "Hugo tem | cestas de morangos. Cada cesta tem | morangos. Quantos morangos ele tem no total?",
    "Laura tem | garrafas de água. Cada garrafa pode encher | copos. Quantos copos de água ela pode encher no total?",
    "Bruno tem | caixas de bolas. Cada caixa tem | bolas. Quantas bolas ele tem no total?",
    "Marina tem | potes de massinha. Cada pote tem | moldes. Quantos moldes ela tem no total?",
    "Gustavo tem | caixas de lápis de cera. Cada caixa tem | lápis de cera. Quantos lápis de cera ele tem no total?",
    "Isabela tem | cestas de flores. Cada cesta tem | flores. Quantas flores ela tem no total?",
    "Carlos tem | potes de geleia. Cada pote tem | colheres. Quantas colheres de geleia ele tem no total?",
    "Rita tem | cestas de ovos de Páscoa. Cada cesta tem | ovos de Páscoa. Quantos ovos de Páscoa ela tem no total?",
    "Eduardo tem | vidros de tintas guache. Cada vidro tem | pincéis. Quantos pincéis ele tem no total?",
    "Alice tem | caixas de giz de cera. Cada caixa tem | giz de cera. Quantos giz de cera ela tem no total?",
    "Fernando tem | caixas de piões. Cada caixa tem | piões. Quantos piões ele tem no total?",
    "Larissa tem | pacotes de adesivos. Cada pacote tem | adesivos. Quantos adesivos ela tem no total?",
    "Gabriel tem | sacolas de pipoca. Cada sacola tem | pipocas. Quantas pipocas ele tem no total?",
    "Carolina tem | caixas de gizes de cera. Cada caixa tem | giz de cera. Quantos gizes de cera ela tem no total?",
    "Felipe tem | cestas de ovos de Páscoa. Cada cesta tem | ovos de Páscoa. Quantos ovos de Páscoa ele tem no total?",
    "Juliana tem | frascos de cola. Cada frasco tem | pincéis. Quantos pincéis ela tem no total?",
    "Rodrigo tem | caixas de lápis de cor. Cada caixa tem | lápis de cor. Quantos lápis de cor ele tem no total?",
    "Vitória tem | sacolas de balas. Cada sacola tem | balas. Quantas balas ela tem no total?",
    "Henrique tem | pacotes de canetas coloridas. Cada pacote tem | canetas coloridas. Quantas canetas coloridas ele tem no total?",
    "Lara tem | cestas de morangos. Cada cesta tem | morangos. Quantos morangos ela tem no total?",
    "João Pedro tem | caixas de lápis de cera. Cada caixa tem | lápis de cera. Quantos lápis de cera ele tem no total?",
    "Luiza tem | frascos de cola. Cada frasco tem | pincéis. Quantos pincéis ela tem no total?",
    "Miguel tem | caixas de gizes de cera. Cada caixa tem | giz de cera. Quantos gizes de cera ele tem no total?",
    "Maria Eduarda tem | sacolas de balas. Cada sacola tem | balas. Quantas balas ela tem no total?",
    "Pedro Henrique tem | pacotes de canetas coloridas. Cada pacote tem | canetas coloridas. Quantas canetas coloridas ele tem no total?",
  ];
  static List<List<LevelData>> levels = [
    [
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["12", "47"], 0, 0, 0)
      ], 90, 30, sumQuestions[0]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["67", "39"], 0, 0, 0)
      ], 90, 30, sumQuestions[1]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["59", "82"], 0, 0, 0)
      ], 90, 30, sumQuestions[2]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["107", "293"], 0, 0, 0)
      ], 80, 35, sumQuestions[3]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["587", "812"], 0, 0, 0)
      ], 80, 35, sumQuestions[4]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["1589", "2321"], 0, 0, 0)
      ], 80, 35, sumQuestions[5]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["3547", "9421"], 0, 0, 0)
      ], 70, 40, sumQuestions[6]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["86391", "13443"], 0, 0, 0)
      ], 70, 40, sumQuestions[7]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["67641", "84195"], 0, 0, 0)
      ], 70, 40, sumQuestions[8]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["54194", "71476"], 0, 0, 0)
      ], 60, 45, sumQuestions[9]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["23177", "13478"], 0, 0, 0)
      ], 60, 45, sumQuestions[10]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["494197", "149816"], 0, 0, 0)
      ], 60, 45, sumQuestions[11]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["971792", "132509"], 0, 0, 0)
      ], 50, 50, sumQuestions[12]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["119862", "756194"], 0, 0, 0)
      ], 50, 50, sumQuestions[13]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["432159", "874613"], 0, 0, 0)
      ], 50, 50, sumQuestions[14]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["948956", "57410"], 0, 0, 0)
      ], 40, 55, sumQuestions[15]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["34424", "427919"], 0, 0, 0)
      ], 40, 55, sumQuestions[16]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["14981", "2379419"], 0, 0, 0)
      ], 40, 55, sumQuestions[17]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["974512", "6514267"], 0, 0, 0)
      ], 30, 60, sumQuestions[18]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["1265730", "7291045"], 0, 0, 0)
      ], 30, 60, sumQuestions[19]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["4698458", "6528096"], 0, 0, 0)
      ], 30, 60, sumQuestions[20]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["5084175", "1679021"], 0, 0, 0)
      ], 25, 65, sumQuestions[21]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["94685296", "105761"], 0, 0, 0)
      ], 25, 65, sumQuestions[22]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["25164857", "42"], 0, 0, 0)
      ], 25, 65, sumQuestions[23]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["69845021", "98674836"], 0, 0, 0)
      ], 20, 70, sumQuestions[24]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["174015457", "9685410"], 0, 0, 0)
      ], 20, 70, sumQuestions[25]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["874230415", "897438154"], 0, 0, 0)
      ], 20, 70, sumQuestions[26]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["7840210401", "89641251"], 0, 0, 0)
      ], 15, 75, sumQuestions[27]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["1657629427", "581789717"], 0, 0, 0)
      ], 15, 75, sumQuestions[28]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["3219498168", "9817985157"], 0, 0, 0)
      ], 15, 75, sumQuestions[29]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["75468418505", "1320167578"], 0, 0, 0)
      ], 10, 80, sumQuestions[30]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["63432765214", "31451614564"], 0, 0, 0)
      ], 10, 80, sumQuestions[31]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["631654101359", "13467126749"], 0, 0, 0)
      ], 10, 80, sumQuestions[32]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["16879415215665", "9863786412379"], 0, 0, 0)
      ], 5, 90, sumQuestions[33]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["8514875613207984", "1898745641674984"], 0, 0, 0)
      ], 5, 90, sumQuestions[34]),
      LevelData.withQuestion([
        MathStack("+", 0, 0, ["95176342788654367", "81409564163416946"], 0, 0, 0)
      ], 5, 90, sumQuestions[35]),
    ],
    [
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["12", "47"], 0, 0, 0)
      ], 90, 30, multiplicationQuestions[0]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["67", "39"], 0, 0, 0)
      ], 90, 30, multiplicationQuestions[1]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["24", "54"], 0, 0, 0)
      ], 90, 30, multiplicationQuestions[2]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["99", "99"], 0, 0, 0)
      ], 80, 35, multiplicationQuestions[3]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["456", "27"], 0, 0, 0)
      ], 80, 35, multiplicationQuestions[4]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["894", "132"], 0, 0, 0)
      ], 80, 35, multiplicationQuestions[5]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["153", "645"], 0, 0, 0)
      ], 70, 40, multiplicationQuestions[6]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["666", "13"], 0, 0, 0)
      ], 70, 40, multiplicationQuestions[7]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["963", "147"], 0, 0, 0)
      ], 70, 40, multiplicationQuestions[8]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["146", "782"], 0, 0, 0)
      ], 60, 45, multiplicationQuestions[9]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["485", "689"], 0, 0, 0)
      ], 60, 45, multiplicationQuestions[10]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["987", "159"], 0, 0, 0)
      ], 60, 45, multiplicationQuestions[11]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["4896", "42"], 0, 0, 0)
      ], 50, 50, multiplicationQuestions[12]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["7968", "25"], 0, 0, 0)
      ], 50, 50, multiplicationQuestions[13]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["1645", "146"], 0, 0, 0)
      ], 50, 50, multiplicationQuestions[14]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["9848", "657"], 0, 0, 0)
      ], 40, 55, multiplicationQuestions[15]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["8457", "1136"], 0, 0, 0)
      ], 40, 55, multiplicationQuestions[16]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["5941", "1453"], 0, 0, 0)
      ], 40, 55, multiplicationQuestions[17]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["4196", "9685"], 0, 0, 0)
      ], 30, 60, multiplicationQuestions[18]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["9321", "4968"], 0, 0, 0)
      ], 30, 60, multiplicationQuestions[19]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["41968", "92"], 0, 0, 0)
      ], 25, 60, multiplicationQuestions[20]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["52761", "54"], 0, 0, 0)
      ], 25, 65, multiplicationQuestions[21]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["96837", "841"], 0, 0, 0)
      ], 25, 65, multiplicationQuestions[22]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["63698", "1698"], 0, 0, 0)
      ], 20, 65, multiplicationQuestions[23]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["41726", "2917"], 0, 0, 0)
      ], 20, 70, multiplicationQuestions[24]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["91757", "3146"], 0, 0, 0)
      ], 20, 70, multiplicationQuestions[25]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["45673", "7864"], 0, 0, 0)
      ], 15, 70, multiplicationQuestions[26]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["32197", "6546"], 0, 0, 0)
      ], 15, 75, multiplicationQuestions[27]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["19641", "19641"], 0, 0, 0)
      ], 15, 75, multiplicationQuestions[28]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["34745", "27873"], 0, 0, 0)
      ], 15, 75, multiplicationQuestions[29]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["24789", "74538"], 0, 0, 0)
      ], 10, 80, multiplicationQuestions[30]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["78987", "78987"], 0, 0, 0)
      ], 10, 80, multiplicationQuestions[31]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["98413", "49863"], 0, 0, 0)
      ], 10, 80, multiplicationQuestions[32]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["49652", "74968"], 0, 0, 0)
      ], 5, 90, multiplicationQuestions[33]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["93684", "36786"], 0, 0, 0)
      ], 5, 90, multiplicationQuestions[5]),
      LevelData.withQuestion([
        MathStack("x", 0, 0, ["695874", "846579"], 0, 0, 0)
      ], 5, 90, multiplicationQuestions[10]),
    ]
  ];

  static Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    next[0] = prefs.getInt('next0') ?? 1;
    next[1] = prefs.getInt('next1') ?? 1;
    hamburgerType = prefs.getInt('hamburgerType') ?? 0;

    for(int i = 0; i < levels.length; i++){
      levelsWithoutMistakes.add([]);
      for(int j = 0; j < levels[i].length; j++){
        levelsWithoutMistakes[i].add(prefs.getBool('mistakes${i}_$j') ?? false);
        if(levelsWithoutMistakes[i][j]){
          totalWithoutMistakes++;
        }
      }
    }
  }

  static void addDemoLevels(int sum, int multiplication){
    for(int i = levels[0].length + 1; i <= sum; i++){
      levels[0].add(LevelData.withQuestion([MathStack("+", 0, 0, ["1", "1"], 0, 0, 0)], 90, 30, "TODO $i : | + | ?"));
    }

    for(int i = levels[1].length + 1; i <= multiplication; i++){
      levels[1].add(LevelData.withQuestion([MathStack("x", 0, 0, ["1", "1"], 0, 0, 0)], 90, 30, "TODO $i : | x | ?"));
    }
  }

  static LevelData getLevel(){
    return type >= 0 ? levels[type][actual] : getCustomLevel();
  }

  static LevelData getNextLevel(){
    return type >= 0 ? levels[type][++actual] : getCustomLevel();
  }

  static int getTotalLevels(){
    return levels[type].length;
  }

  static bool hasNextLevel(){
    return type < 0 || getTotalLevels() > actual + 1;
  }

  static LevelData getCustomLevel(){

    var mathStack = [MathStack(operators[operator], 0, 0, getNumberList(2).map((e) => e.toString()).toList(), 0, 0, 0)];

    return LevelData(mathStack, correctTimeList[time], wrongTimeList[time]);
  }

  static Future<void> finish(bool mistakes) async {
    if(type >= 0){
      final prefs = await SharedPreferences.getInstance();
      if(next[type] == actual + 1) {
        next[type]++;
        await prefs.setInt("next$type", next[type]);
        DatabaseProvider databaseProvider = DatabaseProvider();
        databaseProvider.saveUserData();
      }

      if(!mistakes && !levelsWithoutMistakes[type][actual]){
        levelsWithoutMistakes[type][actual] = true;
        await prefs.setBool("mistakes${type}_$actual", true);
        totalWithoutMistakes++;
      }
    }
  }
}