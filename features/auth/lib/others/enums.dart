// Copyright 2024 Fikret Şengül. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/// `AuthStatus` is an enum representing the current authentication status of the application.
/// It is used to easily track and manage the authentication state within the app.
///
/// - `initial`: Indicates that the authentication status is not yet determined.
/// - `unauthenticated`: Represents a state where the user is not authenticated.
/// - `authenticated`: Represents a state where the user is successfully authenticated.
enum AuthStatus { initial, unauthenticated, authenticated }
