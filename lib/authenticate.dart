import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Autentica o usuário usando o Google Sign-In no Firebase.
/// Retorna um [UserCredential] se a autenticação for bem-sucedida ou lança uma exceção em caso de erro.
Future<UserCredential> signInWithGoogle() async {
  try {
    // Inicia o fluxo de autenticação do Google
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Verifica se o usuário cancelou a autenticação
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'user-cancelled',
        message: 'A autenticação com o Google foi cancelada pelo usuário.',
      );
    }

    // Obtém os detalhes de autenticação do Google
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Cria a credencial do Firebase
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Efetua o login no Firebase com a credencial criada
    return await FirebaseAuth.instance.signInWithCredential(credential);
  } catch (e) {
    // Trata as exceções e lança um erro genérico em caso de falha
    throw FirebaseAuthException(
      code: 'sign-in-failed',
      message: 'Ocorreu um erro ao fazer login com o Google: $e',
    );
  }
}
