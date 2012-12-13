package jvparser;

import org.eclipse.jdt.core.dom.AST;
import org.eclipse.jdt.core.dom.ASTParser;
import org.eclipse.jdt.core.dom.ASTVisitor;
import org.eclipse.jdt.core.dom.CatchClause;
import org.eclipse.jdt.core.dom.ConditionalExpression;
import org.eclipse.jdt.core.dom.DoStatement;
import org.eclipse.jdt.core.dom.Expression;
import org.eclipse.jdt.core.dom.ExpressionStatement;
import org.eclipse.jdt.core.dom.ForStatement;
import org.eclipse.jdt.core.dom.IfStatement;
import org.eclipse.jdt.core.dom.SwitchCase;
import org.eclipse.jdt.core.dom.WhileStatement;

public class Main {
	public class McCabeVisitor extends ASTVisitor {

		private int cyclomatic = 1;

		private String source;

		McCabeVisitor(String source) {
			this.source = source;
		}

		public boolean visit(CatchClause node) {
			cyclomatic++;
			return true;
		}

		public boolean visit(ConditionalExpression node) {
			cyclomatic++;
			inspectExpression(node.getExpression());
			return true;
		}

		public boolean visit(DoStatement node) {
			cyclomatic++;
			inspectExpression(node.getExpression());
			return true;
		}

		public boolean visit(ForStatement node) {
			cyclomatic++;
			inspectExpression(node.getExpression());
			return true;
		}

		public boolean visit(IfStatement node) {
			cyclomatic++;
			inspectExpression(node.getExpression());
			return true;
		}

		public boolean visit(SwitchCase node) {
			if (!node.isDefault())
				cyclomatic++;
			return true;
		}

		public boolean visit(WhileStatement node) {
			cyclomatic++;
			inspectExpression(node.getExpression());
			return true;
		}

		public boolean visit(ExpressionStatement exs) {
			inspectExpression(exs.getExpression());
			return false;
		}

		public int getCyclomatic() {
			return cyclomatic;
		}

		/**
		 * Count occurrences of && and || (conditional and or) Fix for BUG 740253
		 * 
		 * @param ex
		 */
		private void inspectExpression(Expression ex) {
			if ((ex != null) && (source != null)) {
				int start = ex.getStartPosition();
				int end = start + ex.getLength();
				String expression = source.substring(start, end);
				char[] chars = expression.toCharArray();
				for (int i = 0; i < chars.length - 1; i++) {
					char next = chars[i];
					if ((next == '&' || next == '|') && (next == chars[i + 1])) {
						cyclomatic++;
					}
				}
			}
		}
	}

	public void calculate(String src) {
		McCabeVisitor mcb = new McCabeVisitor(src);
		ASTParser parser = ASTParser.newParser(AST.JLS3);
		parser.setKind(ASTParser.K_COMPILATION_UNIT);
		parser.setResolveBindings(true);
		parser.setSource(src.toCharArray());
		parser.createAST(null).accept(mcb);
		mcb.getCyclomatic();
	}

	public Main() {
		calculate("");
	}
}
