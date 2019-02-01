import { Component, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  @ViewChild('f') onSignUpForm  = NgForm;
  defaultQuestion = 'pet';
  answer = '';
  genders = ['male', 'female'];
  user = {
    username: '',
    email: '',
    secretQuestion: '',
    gender: '',
    answer: ''
  };
  submitted = false;

  suggestUserName() {
    const suggestedName = 'Superuser';

    // this.onSignUpForm.form.setValue({
    //   userData: {
    //     username: suggestedName,
    //     email: ''
    //   },
    //   secret: 'pet',
    //   questionAnswer: '',
    //   gender: 'male'
    // });
    this.onSignUpForm.form.patchValue({
      userData: {
        username: suggestedName
      }
    });
  }

  onSubmit() {
   this.submitted = true;
   this.user.username = this.onSignUpForm.value.userData.username;
   this.user.email = this.onSignUpForm.value.userData.email;
   this.user.secretQuestion = this.onSignUpForm.value.secret;
   this.user.answer = this.onSignUpForm.value.questionAnswer;
   this.user.gender = this.onSignUpForm.value.gender;

   this.onSignUpForm.reset();
  }
}
