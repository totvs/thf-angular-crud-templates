'use strict';

import * as vscode from 'vscode';

import { Observable } from 'rxjs';

import { CRUDSimple } from './model/CRUDSimple';

export function activate(context: vscode.ExtensionContext) {

    let componentNameInput: vscode.InputBoxOptions = {
        prompt: 'Please enter \'component\' name in camelCase',
        placeHolder: 'componentName',
        validateInput: validateInputValue
    };

    let thf2CRUDSimple = vscode.commands.registerCommand('extension.thf2CRUDSimple', () => {
        showInput(componentNameInput).concatMap(value => {
            if (!value) return Observable.empty();
            return CRUDSimple.createComponent(value);
        }).subscribe(showCompletedMessage, showErrorMessage);
    });

    function validateInputValue(value: string): string {
        if (!value || value.length === 0) return 'Name can not be empty!';
        else return undefined;
    };

    function showInput(options: vscode.InputBoxOptions): Observable<string> {
        return Observable.from(vscode.window.showInputBox(options));
    };

    function showCompletedMessage(): void {
        vscode.window.setStatusBarMessage('CRUD component successfuly created!', 5000);
    };

    function showErrorMessage(err: Error): void {
        if (err.message) vscode.window.showErrorMessage(err.message);
    };

    context.subscriptions.push(thf2CRUDSimple);
}

export function deactivate() { }
